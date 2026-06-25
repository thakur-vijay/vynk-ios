//
//  DefaultCameraRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
@preconcurrency import AVFoundation

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

    func permissionStatus()async -> CameraPermissionStatus {
        await engine.permissionStatus()
    }

    func requestPermission() async throws -> CameraPermissionStatus {
        try await engine.requestPermission()
    }

    func configureSession(mode: CameraMode, position: CameraPosition)async throws {
        try await engine.configureSession(mode: mode, position: position)
    }
    
    func switchCamera(to position: CameraPosition)async throws {
        try await engine.switchCamera(to: position)
    }

    func startSession()async {
        await engine.startSession()
    }

    func stopSession()async {
       await engine.stopSession()
    }

    func capturePhoto(flashMode: CameraFlashMode) async throws -> CameraOutput {
        try await engine.capturePhoto(flashMode: flashMode)
    }
    
    func startRecording()async throws {
        try await engine.startRecording()
    }
    
    func stopRecording() async throws -> CameraOutput {
        return try await engine.stopRecording()
    }
    
    func supportedZoomLevels(position: CameraPosition) async -> [CameraZoomLevel] {
        return await engine.supportedZoomLevels(position: position)
    }
    
    func setZoomLevel(_ level: CameraZoomLevel) async throws {
        try await engine.setZoomLevel(level)
    }
    
    func setZoomFactor(_ factor: CGFloat) async throws {
        try await engine.setZoomFactor(factor)
    }
    
}
