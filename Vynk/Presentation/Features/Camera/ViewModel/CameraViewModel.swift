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

    func capturePhoto() async{
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

    private func startCameraSession() async throws {
        try await cameraSessionUseCase.configureSession(mode: selectedMode, position: selectedPosition)
        await cameraSessionUseCase.startSession()
        isSessionRunning = true
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
