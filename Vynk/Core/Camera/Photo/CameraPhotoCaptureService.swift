//
//  CameraPhotoCaptureService.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import AVFoundation
import UIKit

final class CameraPhotoCaptureService {

    private let sessionManager: CameraSessionManager
    private let photoOutput = AVCapturePhotoOutput()

    private var photoDelegate: CameraPhotoCaptureDelegate?
    private var isCapturingPhoto = false

    init(sessionManager: CameraSessionManager) {
        self.sessionManager = sessionManager
    }

    func attachOutput() throws {
        try sessionManager.addOutput(photoOutput)
    }

    func detachOutput() {
        sessionManager.removeOutput(photoOutput)
    }
    
    func capturePhoto(flashMode: CameraFlashMode) async throws -> CameraOutput {
        
        guard !isCapturingPhoto else {
            throw CameraSessionError.captureInProgress
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
            Task {
                try? self.applyRotationAndMirroring()
                self.photoOutput.capturePhoto(
                    with: settings,
                    delegate: delegate
                )
            }
        }
    }
    
    private func applyRotationAndMirroring() throws {
        let coordinator = try sessionManager.makeRotationCoordinator()

        if let connection = photoOutput.connection(with: .video),
           connection.isVideoRotationAngleSupported(
            coordinator.videoRotationAngleForHorizonLevelCapture
           ) {
            connection.videoRotationAngle =
                coordinator.videoRotationAngleForHorizonLevelCapture
        }

        if let connection = photoOutput.connection(with: .video),
           connection.isVideoMirroringSupported {

            let position = sessionManager.position
            switch position {
            case .front:
                connection.isVideoMirrored = true
            case .back:
                connection.isVideoMirrored = false
            }
        }
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
}
