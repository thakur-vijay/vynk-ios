//
//  CameraViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
import AVFoundation
import VynkCameraKit
import VynkMediaKit

@MainActor
@Observable
final class CameraViewModel {

    let mediaProvider: MediaProviding
    private let cameraSessionUseCase: CameraSessionUseCase
    private(set) var permissionStatus: CameraPermissionStatus = .notDetermined
    private(set) var isSessionRunning = false
    private(set) var selectedMode: CameraMode
    private(set) var selectedPosition: CameraPosition
    private(set) var isCapturingPhoto: Bool = false
    private(set) var selectedFlashMode: CameraFlashMode = .off
    private(set) var isRecordingVideo = false
    private(set) var recordingDuration: TimeInterval = 0
    private(set) var zoomFactor: CGFloat = 1
    private var zoomTask: Task<Void, Never>?
    private var zoomGestureBase: CGFloat = 1
    private var isZooming = false
    private(set) var selectedZoomPreset: CameraZoomPreset = .one
    
    private var recordingTask: Task<Void, Never>?
    var capturedOutput: CameraOutput?

    var activeIndex: Int = 1
    var tabs: [GlassSegmentedControl.Tab] = [
        .init(title: "VIDEO"),
        .init(title: "PHOTO"),
    ]
    
    var mediaActionSheet: CameraSheet?
    private(set) var isMediaPermissionGiven: Bool = false
    
    init(
        cameraSessionUseCase: CameraSessionUseCase,
        initialMode: CameraMode = .photo,
        initialPosition: CameraPosition = .back,
        mediaProvider: MediaProviding
    ) {

        self.cameraSessionUseCase = cameraSessionUseCase
        self.selectedMode = initialMode
        self.selectedPosition = initialPosition
        self.mediaProvider = mediaProvider
        self.zoomGestureBase = selectedZoomPreset.zoomFactor
    }

    var session: AVCaptureSession {
        cameraSessionUseCase.session
    }

    func prepareCamera() async {
        do {

            permissionStatus = try await cameraSessionUseCase.prepareCamera(
                mode: selectedMode,
                position: selectedPosition,
                zoomFactor: selectedZoomPreset.zoomFactor
            )

            isSessionRunning = permissionStatus == .authorized

        } catch {
            Log.error(error.localizedDescription, String(describing: self))

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
            Log.error(error.localizedDescription, String(describing: self))
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
        case .scanner: break
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
            Log.error(error.localizedDescription, String(describing: self))
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

            Log.error(error.localizedDescription, String(describing: self))

        }
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
    
    func beginZoomGesture() {

        zoomGestureBase = max(min(zoomFactor, CameraConstants.maximumZoomFactor), 1)

        zoomTask?.cancel()

    }

    func updateZoomGesture(scale: CGFloat) {
        
        let targetZoom = min(
            CameraConstants.maximumZoomFactor,
            max(
                CameraConstants.minimumZoomFactor,
                zoomGestureBase * scale
            )
        )
        
        zoomTask?.cancel()

        zoomTask = Task { [weak self] in

            guard let self else { return }

            try? await Task.sleep(for: .milliseconds(16))

            await self.setZoomFactor(targetZoom)

        }

    }

    func endZoomGesture() {

        zoomTask?.cancel()

        zoomTask = nil
        
        zoomGestureBase = max(min(zoomFactor, CameraConstants.maximumZoomFactor), 1)

    }
    
    func selectZoomPreset(

        _ preset: CameraZoomPreset

    ) async {

        do {

            let factor = preset.zoomFactor

            try await cameraSessionUseCase

                .setZoomFactor(factor)

            selectedZoomPreset = preset

            zoomFactor = factor

            zoomGestureBase = factor   // <-- important

        } catch {

        }

    }
    
    private func setZoomFactor(
        _ factor: CGFloat
    ) async {

        do {

            try await cameraSessionUseCase
                .setZoomFactor(factor)

            zoomFactor = factor
        } catch {

            Log.error(error.localizedDescription, String(describing: self))

        }
    }
    
    func isMediaPermissionGiven() async {
        do {
            print("isMediaPermissionGiven", "called")
            isMediaPermissionGiven = try await mediaProvider.isPhotoLibraryPermissionGiven()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    ///handle media
    func handleMediaAction() {
        if isMediaPermissionGiven {
            mediaActionSheet = .mediaPicker
        }else {
            mediaActionSheet = .mediaPermissionDenied
        }
    }
}
