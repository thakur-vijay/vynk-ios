//
//  CameraDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

@preconcurrency import AVFoundation
import UIKit

@available(iOS 17.0, *)
public final class CameraEngine {
    
    private let sessionManager: CameraSessionManager
    private let photoCaptureService: CameraPhotoCaptureService
    private let videoRecordingService: CameraVideoRecordingService
    private let qrScannerService: QRScannerService
    
    public init(
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
    
    public func configureSession(
        mode: CameraMode,
        position: CameraPosition
    ) async throws {

        try sessionManager.configureSession(
            preset: mode.sessionPreset,
            position: position
        )
        await detachAllOutputs()
        switch mode {

        case .photo:

            try photoCaptureService.attachOutput()

        case .video:

            try videoRecordingService.attachOutput()

        case .scanner:
            try qrScannerService.attachOutput()
        }
    }
    
    private func detachAllOutputs() async {

         photoCaptureService.detachOutput()

         videoRecordingService.detachOutput()

         qrScannerService.detachOutput()
    }
    
    @MainActor
    public func prepareCamera(
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
    
    
    public func capturePhoto(
        flashMode: CameraFlashMode
    ) async throws -> CameraOutput {
        try await photoCaptureService.capturePhoto(
            flashMode: flashMode
        )
    }
    
    public func startRecording() throws {
        try videoRecordingService.startRecording()
    }
    
    public func stopRecording() async throws -> CameraOutput {
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
    
    public nonisolated var session: AVCaptureSession {
        sessionManager.session
    }

    public func permissionStatus()-> CameraPermissionStatus {
        sessionManager.permissionStatus()
    }

    public func requestPermission() async throws -> CameraPermissionStatus {
        await sessionManager.requestPermission()
    }
    
    public func switchCamera(to position: CameraPosition)throws {
        try sessionManager.switchCamera(to: position)
    }

    public func startSession() {
         sessionManager.startSession()
    }

    public func stopSession() {
        sessionManager.stopSession()
    }
    
    public func supportedZoomLevels(position: CameraPosition) -> [CameraZoomLevel] {
        return sessionManager.supportedZoomLevels(position: position)
    }
    
    public func setZoomLevel(_ level: CameraZoomLevel) throws {
        try sessionManager.setZoomLevel(level)
    }
    
    public func setZoomFactor(_ factor: CGFloat) throws {
        try sessionManager.setZoomFactor(factor)
    }
    
    public func setTorch(enabled: Bool) throws {
        try sessionManager.setTorch(enabled: enabled)
    }
    
    public func observeQRCode() -> AsyncStream<ScannerResult> {
        qrScannerService.observeQRCode()
    }

    public enum CameraDataSourceError: Error {
        case captureNotImplemented
        case cameraUnavailable
        case unableToAddInput
        case unableToAddOutput
        case photoDataMissing
        case invalidPhotoData
        case captureInProgress
    }
}
