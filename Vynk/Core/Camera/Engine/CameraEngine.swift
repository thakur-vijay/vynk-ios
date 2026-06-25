//
//  CameraDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI
@preconcurrency import AVFoundation

actor CameraEngine {
    
    private let sessionManager: CameraSessionManager
    private let photoCaptureService: CameraPhotoCaptureService
    private let videoRecordingService: CameraVideoRecordingService
    private let qrScannerService: QRScannerService
    
    init(
        sessionManager: CameraSessionManager,
        photoCaptureService: CameraPhotoCaptureService,
        videoRecordingService: CameraVideoRecordingService,
        qrScannerService: QRScannerService
    ) {
        self.sessionManager = sessionManager
        self.photoCaptureService = photoCaptureService
        self.videoRecordingService = videoRecordingService
        self.qrScannerService = qrScannerService
    }
    
    func configureSession(
        mode: CameraMode,
        position: CameraPosition
    ) async throws {

        try await sessionManager.configureSession(
            preset: mode.sessionPreset,
            position: position
        )
        await detachAllOutputs()
        switch mode {

        case .photo:

            try await photoCaptureService.attachOutput()

        case .video:

            try await videoRecordingService.attachOutput()

        case .scanner:
            try await qrScannerService.attachOutput()
        }
    }
    
    private func detachAllOutputs() async {

        await photoCaptureService.detachOutput()

        await videoRecordingService.detachOutput()

        await qrScannerService.detachOutput()
    }
    
    @MainActor
    func prepareCamera(
        mode: CameraMode,
        position: CameraPosition,
        zoomFactor: CGFloat
    ) async throws -> CameraPermissionStatus {

        let status = sessionManager.permissionStatus()

        switch status {

        case .authorized:

            try await configureSession(
                mode: mode,
                position: position
            )

            sessionManager.startSession()
            try sessionManager.setZoomFactor(
                zoomFactor
            )

            return .authorized

        case .notDetermined:

            let newStatus = await sessionManager.requestPermission()

            guard newStatus == .authorized else {
                return newStatus
            }

            try await configureSession(
                mode: mode,
                position: position
            )

            sessionManager.startSession()

            try sessionManager.setZoomFactor(
                zoomFactor
            )

            return .authorized

        case .denied, .restricted:

            return status
        }
    }
    
    
    func capturePhoto(
        flashMode: CameraFlashMode
    ) async throws -> CameraOutput {
        try await photoCaptureService.capturePhoto(
            flashMode: flashMode
        )
    }
    
    func startRecording()async throws {
        try await videoRecordingService.startRecording()
    }
    
    func stopRecording() async throws -> CameraOutput {
        try await videoRecordingService.stopRecording()
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
    
    nonisolated var session: AVCaptureSession {
        sessionManager.session
    }

    func permissionStatus()async -> CameraPermissionStatus {
        await sessionManager.permissionStatus()
    }

    func requestPermission() async throws -> CameraPermissionStatus {
        await sessionManager.requestPermission()
    }
    func switchCamera(to position: CameraPosition)async throws {
        try await sessionManager.switchCamera(to: position)
    }

    func startSession()async {
        await sessionManager.startSession()
    }

    func stopSession()async {
       await sessionManager.stopSession()
    }
    
    func supportedZoomLevels(position: CameraPosition) async -> [CameraZoomLevel] {
        return await sessionManager.supportedZoomLevels(position: position)
    }
    
    func setZoomLevel(_ level: CameraZoomLevel) async throws {
        try await sessionManager.setZoomLevel(level)
    }
    
    func setZoomFactor(_ factor: CGFloat) async throws {
        try await sessionManager.setZoomFactor(factor)
    }
    
    func setTorch(enabled: Bool) async throws {
        try await sessionManager.setTorch(enabled: enabled)
    }
    
    @MainActor
    func observeQRCode() -> AsyncStream<ScannerResult> {
        qrScannerService.observeQRCode()
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
