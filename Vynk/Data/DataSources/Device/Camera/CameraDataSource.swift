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
    
    private var videoDelegate: CameraVideoRecordingDelegate?
    private var videoContinuation: CheckedContinuation<CameraOutput, Error>?
    private var recordingURL: URL?
    private var isRecordingVideo = false
    private var currentZoomLevel: CameraZoomLevel = .wide
    
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
        var zoomLevel: CameraZoomLevel
        switch position {
        case .front:
            zoomLevel = .wide
        case .back:
            zoomLevel = currentZoomLevel
        }
        let input = try makeVideoInput(position: position, zoomLevel: zoomLevel)
        
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
        var zoomLevel: CameraZoomLevel
        switch position {
        case .front:
            zoomLevel = .wide
        case .back:
            zoomLevel = currentZoomLevel
        }
        let input = try makeVideoInput(position: position, zoomLevel: zoomLevel)
        
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
    
    func startRecording() throws {
        guard !isRecordingVideo else {
            throw CameraDataSourceError.recordingInProgress
        }

        guard !movieOutput.isRecording else {
            throw CameraDataSourceError.recordingInProgress
        }

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("mov")

        let delegate = CameraVideoRecordingDelegate { [weak self] result in
            Task {
                await self?.finishVideoRecording(result)
            }
        }

        videoDelegate = delegate
        recordingURL = url
        isRecordingVideo = true
        movieOutput.startRecording(
            to: url,
            recordingDelegate: delegate
        )
    }
    
    func stopRecording() async throws -> CameraOutput {
        guard isRecordingVideo else {
            throw CameraDataSourceError.notRecording
        }
        guard movieOutput.isRecording else {
            throw CameraDataSourceError.notRecording
        }
        
        return try await withCheckedThrowingContinuation {(
            continuation: CheckedContinuation<CameraOutput, Error>
        ) in
            videoContinuation = continuation
            movieOutput.stopRecording()
        }

    }
    
    private func preferredDevice(
        position: CameraPosition
    ) -> AVCaptureDevice? {

        let devicePosition: AVCaptureDevice.Position
        
        switch position {
        case .front:
            devicePosition = .front
        case .back:
            devicePosition = .back
        }
        switch position {
        case .front:
            return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: devicePosition)
        case .back:
            return AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back)
                ?? AVCaptureDevice.default(.builtInTripleCamera, for: .video, position: .back)
                ?? AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        }
    }
    
    private func makeVideoInput(
        position: CameraPosition,
        zoomLevel: CameraZoomLevel
    ) throws -> AVCaptureDeviceInput {
        guard let device = preferredDevice(position: position) else {

            throw CameraDataSourceError.cameraUnavailable

        }

        return try AVCaptureDeviceInput(device: device)
    }
    
    private func clearPhotoDelegate() {
        photoDelegate = nil
    }
    
    private func clearVideoDelegate(){
        videoDelegate = nil
    }
    
    private func finishPhotoCapture() {
        isCapturingPhoto = false
    }
    
    private func mapFlashMode(_ mode: CameraFlashMode) -> AVCaptureDevice.FlashMode {
        switch mode {
        case .off:
            return .off
        case .auto:
            return .auto
        case .on:
            return .on
        }
    }
    
    private func finishVideoRecording(_ result: Result<URL, Error>) {
        let continuation = videoContinuation
        videoContinuation = nil
        videoDelegate = nil
        recordingURL = nil
        isRecordingVideo = false

        switch result {
        case .success(let url):
            continuation?.resume(
                returning: .video(url)
            )

        case .failure(let error):
            continuation?.resume(
                throwing: error
            )

        }

    }
    
    func supportedZoomLevels(position: CameraPosition) -> [CameraZoomLevel] {
        var levels: [CameraZoomLevel] = [.wide]
        var cameraPosition: AVCaptureDevice.Position
        switch position {
        case .front:
            cameraPosition = .front
        case .back:
            cameraPosition = .back
        }
        let ultraWide = AVCaptureDevice.default(
            .builtInUltraWideCamera,
            for: .video,
            position: cameraPosition
        )

        if ultraWide != nil {
            levels.insert(.ultraWide, at: 0)
        }

        return levels
    }
    
    func setZoomLevel(_ level: CameraZoomLevel) throws {

        session.beginConfiguration()

        defer { session.commitConfiguration() }

        if let videoInput {

            session.removeInput(videoInput)

        }

        let input = try makeVideoInput(

            position: currentPosition,

            zoomLevel: level

        )

        guard session.canAddInput(input) else {

            throw CameraDataSourceError.unableToAddInput

        }

        session.addInput(input)

        videoInput = input

        currentZoomLevel = level

    }
    
    func setZoomFactor(
        _ factor: CGFloat
    ) throws {

        guard let device = videoInput?.device else {
            throw CameraDataSourceError.cameraUnavailable
        }

        try device.lockForConfiguration()

        let maxZoom = min(
            CameraConstants.maximumZoomFactor,
            device.maxAvailableVideoZoomFactor
        )

        let zoomFactor = max(
            CameraConstants.minimumZoomFactor,
            min(
                factor,
                maxZoom
            )
        )

        device.videoZoomFactor = zoomFactor

        device.unlockForConfiguration()
    }

    enum CameraDataSourceError: Error {
        case captureNotImplemented
        case cameraUnavailable
        case unableToAddInput
        case unableToAddOutput
        case photoDataMissing
        case invalidPhotoData
        case captureInProgress
        case recordingInProgress
        case notRecording
    }
}
