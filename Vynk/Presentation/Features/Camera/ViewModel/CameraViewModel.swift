//
//  CameraViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
import AVFoundation

@MainActor
@Observable
final class CameraViewModel {

    private let cameraSessionUseCase: CameraSessionUseCase

    private(set) var permissionStatus: CameraPermissionStatus = .notDetermined
    private(set) var isSessionRunning = false
    private(set) var selectedMode: CameraMode
    private(set) var selectedPosition: CameraPosition
    private(set) var isCapturingPhoto: Bool = false
    private(set) var selectedFlashMode: CameraFlashMode = .off
    private(set) var isRecordingVideo = false
    private(set) var recordingDuration: TimeInterval = 0
    private var recordingTask: Task<Void, Never>?
    var capturedOutput: CameraOutput?

    var activeIndex: Int = 1
    var tabs: [GlassSegmentedControl.Tab] = [
        .init(title: "VIDEO"),
        .init(title: "PHOTO"),
    ]
    
    init(
        cameraSessionUseCase: CameraSessionUseCase,
        initialMode: CameraMode = .photo,
        initialPosition: CameraPosition = .back
    ) {

        self.cameraSessionUseCase = cameraSessionUseCase
        self.selectedMode = initialMode
        self.selectedPosition = initialPosition
    }

    var session: AVCaptureSession {
        cameraSessionUseCase.session
    }

    func prepareCamera() async {
        do {
            let status = await cameraSessionUseCase.permissionStatus()
            permissionStatus = status

            switch status {
            case .authorized:
                try await startCameraSession()

            case .notDetermined:
                let newStatus = try await cameraSessionUseCase.requestPermission()
                permissionStatus = newStatus

                if newStatus == .authorized {
                    try await startCameraSession()
                }

            case .denied, .restricted:
                break
            }
        } catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }

    func stopCamera()async{
        await cameraSessionUseCase.stopSession()
        isSessionRunning = false
    }
    
    func switchCamera()async {
        let newPosition: CameraPosition =
            selectedPosition == .back ? .front : .back
        do {
            try await cameraSessionUseCase.switchCamera(to: newPosition)
            selectedPosition = newPosition
        } catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }

    }
    
    func switchMode()async {
        selectedMode = activeIndex == 0 ? .video : .photo
    }
    
    func capture() async {
        
        switch selectedMode {

        case .photo:

        await capturePhoto()

        case .video:

            await toggleRecording()

        }

    }

    private func capturePhoto() async{
        guard !isCapturingPhoto else { return }
        isCapturingPhoto = true
        defer {
            isCapturingPhoto = false
        }
        do {
            capturedOutput = try await cameraSessionUseCase.capturePhoto(flashMode: selectedFlashMode)
            
        } catch {
            dump(error)
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
    
    private func toggleRecording() async {

        do {

            if isRecordingVideo {

                let output = try await cameraSessionUseCase.stopRecording()

                capturedOutput = output
                
                stopRecordingTimer()

                isRecordingVideo = false

            } else {

                try await cameraSessionUseCase.startRecording()

                isRecordingVideo = true
                startRecordingTimer()
            }

        } catch {

            stopRecordingTimer()
            
            isRecordingVideo = false

            AppLogger.error(
                error.localizedDescription,
                tag: String(describing: self)
            )
        }
    }

    private func startCameraSession() async throws {
        try await cameraSessionUseCase.configureSession(mode: selectedMode, position: selectedPosition)
        await cameraSessionUseCase.startSession()
        isSessionRunning = true
    }
    
    private func startRecordingTimer() {

        recordingTask?.cancel()

        recordingDuration = 0

        recordingTask = Task {

            while !Task.isCancelled {

                try? await Task.sleep(
                    for: .seconds(1)
                )

                recordingDuration += 1
            }
        }
    }
    
    private func stopRecordingTimer() {
        recordingTask?.cancel()
        recordingTask = nil
    }
    
    func toggleFlashMode() {
        switch selectedFlashMode {
        case .off:
            selectedFlashMode = .auto
        case .auto:
            selectedFlashMode = .on
        case .on:
            selectedFlashMode = .off
        }
    }
    
}
