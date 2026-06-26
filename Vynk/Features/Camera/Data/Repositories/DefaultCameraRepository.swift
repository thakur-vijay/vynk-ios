//
//  DefaultCameraRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
@preconcurrency import AVFoundation
import VynkCameraKit

final class DefaultCameraRepository: CameraRepository {
  
    private let engine: CameraEngine

    init(engine: CameraEngine) {
        self.engine = engine
    }

    var session: AVCaptureSession {
        engine.session
    }
    
    func prepareCamera(mode: CameraMode, position: CameraPosition, zoomFactor: CGFloat) async throws -> CameraPermissionStatus {
        try await engine.prepareCamera(
            mode: mode,
            position: position,
            zoomFactor: zoomFactor
        )
    }

    func permissionStatus() -> CameraPermissionStatus {
        engine.permissionStatus()
    }

    func requestPermission() async throws -> CameraPermissionStatus {
        try await engine.requestPermission()
    }

    func configureSession(mode: CameraMode, position: CameraPosition)async throws {
        try await engine.configureSession(mode: mode, position: position)
    }
    
    func switchCamera(to position: CameraPosition) throws {
        try engine.switchCamera(to: position)
    }

    func startSession()async {
        engine.startSession()
    }

    func stopSession()async {
        engine.stopSession()
    }

    func capturePhoto(flashMode: CameraFlashMode) async throws -> CameraOutput {
        try await engine.capturePhoto(flashMode: flashMode)
    }
    
    func startRecording() throws {
        try engine.startRecording()
    }
    
    func stopRecording() async throws -> CameraOutput {
        return try await engine.stopRecording()
    }
    
    func supportedZoomLevels(position: CameraPosition) -> [CameraZoomLevel] {
        return engine.supportedZoomLevels(position: position)
    }
    
    func setZoomLevel(_ level: CameraZoomLevel) throws {
        try engine.setZoomLevel(level)
    }
    
    func setZoomFactor(_ factor: CGFloat) throws {
        try engine.setZoomFactor(factor)
    }
    
}
