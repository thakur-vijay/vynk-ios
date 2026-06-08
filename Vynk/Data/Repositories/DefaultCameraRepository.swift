//
//  DefaultCameraRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
@preconcurrency import AVFoundation

final class DefaultCameraRepository: CameraRepository {

    private let dataSource: CameraDataSource

    init(dataSource: CameraDataSource) {
        self.dataSource = dataSource
    }

    var session: AVCaptureSession {
        dataSource.session
    }

    func permissionStatus()async -> CameraPermissionStatus {
        await dataSource.permissionStatus()
    }

    func requestPermission() async throws -> CameraPermissionStatus {
        await dataSource.requestPermission()
    }

    func configureSession(mode: CameraMode, position: CameraPosition)async throws {
        try await dataSource.configureSession(mode: mode, position: position)
    }
    
    func switchCamera(to position: CameraPosition)async throws {
        try await dataSource.switchCamera(to: position)
    }

    func startSession()async {
        await dataSource.startSession()
    }

    func stopSession()async {
       await dataSource.stopSession()
    }

    func capturePhoto() async throws -> CameraOutput {
        try await dataSource.capturePhoto()
    }
}
