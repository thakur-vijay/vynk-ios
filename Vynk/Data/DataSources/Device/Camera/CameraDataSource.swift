//
//  CameraDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI
@preconcurrency import AVFoundation

actor CameraDataSource {

    nonisolated let session = AVCaptureSession()

    private var videoInput: AVCaptureDeviceInput?
    private let photoOutput = AVCapturePhotoOutput()
    private let movieOutput = AVCaptureMovieFileOutput()
    private var photoDelegate: CameraPhotoCaptureDelegate?
    private var isCapturingPhoto: Bool = false
    private var rotationCoordinator: AVCaptureDevice.RotationCoordinator?
    private var currentPosition: CameraPosition = .back

    func permissionStatus() -> CameraPermissionStatus {
        CameraPermissionMapper.map(
            AVCaptureDevice.authorizationStatus(for: .video)
        )
    }

    func requestPermission() async -> CameraPermissionStatus {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        return granted ? .authorized : .denied
    }

    func configureSession(
        mode: CameraMode,
        position: CameraPosition
    ) throws {
        session.beginConfiguration()
        defer { session.commitConfiguration() }

        switch mode {
        case .photo:
            session.sessionPreset = .photo
        case .video:
            session.sessionPreset = .high
        }

        session.inputs.forEach {
            session.removeInput($0)
        }

        session.outputs.forEach {
            session.removeOutput($0)
        }

        let input = try makeVideoInput(position: position)

        guard session.canAddInput(input) else {
            throw CameraDataSourceError.unableToAddInput
        }

        session.addInput(input)
        videoInput = input
        rotationCoordinator = AVCaptureDevice.RotationCoordinator(
            device: input.device,
            previewLayer: nil
        )
        
        guard session.canAddOutput(photoOutput) else {
            throw CameraDataSourceError.unableToAddOutput
        }

        session.addOutput(photoOutput)

        guard session.canAddOutput(movieOutput) else {
            throw CameraDataSourceError.unableToAddOutput
        }

        session.addOutput(movieOutput)
    }

    func switchCamera(to position: CameraPosition) throws {
        session.beginConfiguration()
        defer { session.commitConfiguration() }

        if let videoInput {
            session.removeInput(videoInput)
        }

        let input = try makeVideoInput(position: position)

        guard session.canAddInput(input) else {
            throw CameraDataSourceError.unableToAddInput
        }

        session.addInput(input)
        videoInput = input
        currentPosition = position
    }

    func startSession() {
        guard !session.isRunning else { return }
        session.startRunning()
    }

    func stopSession() {
        guard session.isRunning else { return }
        session.stopRunning()
    }

    func capturePhoto(flashMode: CameraFlashMode) async throws -> CameraOutput {

        guard !isCapturingPhoto else {
            throw CameraDataSourceError.captureInProgress
        }

        isCapturingPhoto = true

        return try await withCheckedThrowingContinuation {
            (
                continuation: CheckedContinuation<CameraOutput, Error>
            ) in

            let settings = AVCapturePhotoSettings()
            
            let avFlashMode = mapFlashMode(flashMode)

            if photoOutput.supportedFlashModes.contains(avFlashMode) {

                settings.flashMode = avFlashMode

            }
        
            let delegate = CameraPhotoCaptureDelegate { [weak self] result in

                Task {
                    guard let self else { return }

                    await self.clearPhotoDelegate()
                    await self.finishPhotoCapture()
                }

                switch result {

                case .success(let image):

                    continuation.resume(
                        returning: CameraOutput.photo(image)
                    )

                case .failure(let error):

                    continuation.resume(
                        throwing: error
                    )
                }
            }

            photoDelegate = delegate
            if let connection = photoOutput.connection(with: .video),
               connection.isVideoRotationAngleSupported(
                    rotationCoordinator?.videoRotationAngleForHorizonLevelCapture ?? 0
               ) {
                connection.videoRotationAngle =
                    rotationCoordinator?.videoRotationAngleForHorizonLevelCapture ?? 0
            }
            if let connection = photoOutput.connection(with: .video), connection.isVideoMirroringSupported {
                switch currentPosition {
                case .front:
                    connection.isVideoMirrored = true
                case .back:
                    connection.isVideoMirrored = false
                }
            }
            photoOutput.capturePhoto(
                with: settings,
                delegate: delegate
            )
        }
    }
    
    func startRecording()async throws {
    }
    
    func stopRecording() async throws -> CameraOutput {
        return .video(.init(string: "")!)
    }

    private func makeVideoInput(
        position: CameraPosition
    ) throws -> AVCaptureDeviceInput {
        let devicePosition: AVCaptureDevice.Position

        switch position {
        case .front:
            devicePosition = .front
        case .back:
            devicePosition = .back
        }

        guard let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: devicePosition
        ) else {
            throw CameraDataSourceError.cameraUnavailable
        }

        return try AVCaptureDeviceInput(device: device)
    }
    
    private func clearPhotoDelegate() {
        photoDelegate = nil
    }
    
    private func finishPhotoCapture() {
        isCapturingPhoto = false
    }
    
    private func mapFlashMode(
        _ mode: CameraFlashMode
    ) -> AVCaptureDevice.FlashMode {
        switch mode {
        case .off:
            return .off
        case .auto:
            return .auto
        case .on:
            return .on
        }
    }

    enum CameraDataSourceError: Error {
        case captureNotImplemented
        case cameraUnavailable
        case unableToAddInput
        case unableToAddOutput
        case photoDataMissing
        case invalidPhotoData
        case captureInProgress
    }
}
