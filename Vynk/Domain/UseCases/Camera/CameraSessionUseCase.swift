//
//  CameraSessionUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import AVFoundation

final class CameraSessionUseCase {

    private let repository: CameraRepository

    init(repository: CameraRepository) {
        self.repository = repository
    }

    var session: AVCaptureSession {
        repository.session
    }

    func permissionStatus() async -> CameraPermissionStatus {
        await repository.permissionStatus()
    }

    func requestPermission() async throws -> CameraPermissionStatus {
        try await repository.requestPermission()
    }

    func configureSession(
        mode: CameraMode,
        position: CameraPosition
    ) async throws {
        try await repository.configureSession(
            mode: mode,
            position: position
        )
    }

    func switchCamera(to position: CameraPosition) async throws {
        try await repository.switchCamera(to: position)
    }

    func startSession()async {
        await repository.startSession()
    }

    func stopSession() async{
        await repository.stopSession()
    }

    func capturePhoto(flashMode: CameraFlashMode) async throws -> CameraOutput {
        try await repository.capturePhoto(flashMode: flashMode)
    }
    
    func startRecording() async throws {
        try await repository.startRecording()
    }

    func stopRecording() async throws -> CameraOutput {
        try await repository.stopRecording()

    }
}
