//
//  CameraSessionManager.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import SwiftUI
@preconcurrency import AVFoundation

final class CameraSessionManager {
    
    nonisolated let session = AVCaptureSession()
    
    private var videoInput: AVCaptureDeviceInput?
    private var currentPosition: CameraPosition = .back
    private var currentZoomLevel: CameraZoomLevel = .wide
    private let sessionQueue = DispatchQueue(
        label: "com.vynk.camera.session",
        qos: .userInitiated
    )

    func permissionStatus() -> CameraPermissionStatus {
        CameraPermissionMapper.map(
            AVCaptureDevice.authorizationStatus(for: .video)
        )
    }
    
    func requestPermission() async -> CameraPermissionStatus {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        return granted ? .authorized : .denied
    }
    
    func configureSession(
        preset: AVCaptureSession.Preset = .high,
        position: CameraPosition = .back
    ) throws {
        
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        
        session.sessionPreset = preset
        
        session.inputs.forEach {
            session.removeInput($0)
        }
        
        let input = try makeVideoInput(
            position: position
        )
        
        guard session.canAddInput(input) else {
            throw CameraSessionError.unableToAddInput
        }
        
        session.addInput(input)
        
        videoInput = input
        currentPosition = position
    }
    
    func switchCamera(
        to position: CameraPosition
    ) throws {
        
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        
        if let videoInput {
            session.removeInput(videoInput)
        }
        
        let input = try makeVideoInput(
            position: position
        )
        
        guard session.canAddInput(input) else {
            throw CameraSessionError.unableToAddInput
        }
        
        session.addInput(input)
        
        videoInput = input
        currentPosition = position
    }
    
    func startSession() {
        sessionQueue.async {
            guard !self.session.isRunning else { return }
            self.session.startRunning()
        }
    }

    func stopSession() {
        sessionQueue.async {
            guard self.session.isRunning else { return }
            self.session.stopRunning()
        }
    }
    
    var position: CameraPosition {
        currentPosition
    }
    
    var currentDevice: AVCaptureDevice? {
        videoInput?.device
    }
    
    private func makeVideoInput(
        position: CameraPosition
    ) throws -> AVCaptureDeviceInput {
        
        guard let device = preferredDevice(
            position: position
        ) else {
            throw CameraSessionError.cameraUnavailable
        }
        
        return try AVCaptureDeviceInput(
            device: device,
        )
    }
    
    private func preferredDevice(
        position: CameraPosition
    ) -> AVCaptureDevice? {
        
        switch position {
            
        case .front:
            return AVCaptureDevice.default(
                .builtInWideAngleCamera,
                for: .video,
                position: .front
            )
            
        case .back:
            return AVCaptureDevice.default(
                .builtInWideAngleCamera,
                for: .video,
                position: .back
            )
        }
    }
    
    func addOutput(
        _ output: AVCaptureOutput
    ) throws {
        
        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }
        
        guard session.canAddOutput(output) else {
            throw CameraSessionError.unableToAddOutput
        }
        
        session.addOutput(output)
    }
    
    func removeOutput(
        _ output: AVCaptureOutput
    ) {
        
        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }
        
        guard session.outputs.contains(output) else {
            return
        }
        
        session.removeOutput(output)
    }
    
    func makeRotationCoordinator() throws -> AVCaptureDevice.RotationCoordinator {
        guard let device = currentDevice else {
            throw CameraSessionError.cameraUnavailable
        }
        
        return AVCaptureDevice.RotationCoordinator(
            device: device,
            previewLayer: nil
        )
    }
    
    func supportedZoomLevels(position: CameraPosition) -> [CameraZoomLevel] {
        var levels: [CameraZoomLevel] = [.wide]
        var cameraPosition: AVCaptureDevice.Position
        switch position {
        case .front:
            cameraPosition = .front
        case .back:
            cameraPosition = .back
        }
        let ultraWide = AVCaptureDevice.default(
            .builtInUltraWideCamera,
            for: .video,
            position: cameraPosition
        )

        if ultraWide != nil {
            levels.insert(.ultraWide, at: 0)
        }

        return levels
    }
    
    func setZoomLevel(_ level: CameraZoomLevel) throws {

        session.beginConfiguration()

        defer { session.commitConfiguration() }

        if let videoInput {

            session.removeInput(videoInput)

        }

        let input = try makeVideoInput(
            position: currentPosition,
        )

        guard session.canAddInput(input) else {

            throw CameraSessionError.unableToAddInput

        }

        session.addInput(input)

        videoInput = input

        currentZoomLevel = level

    }
    
    func setZoomFactor(
        _ factor: CGFloat
    ) throws {

        guard let device = videoInput?.device else {
            throw CameraSessionError.cameraUnavailable
        }

        try device.lockForConfiguration()

        let maxZoom = min(
            CameraConstants.maximumZoomFactor,
            device.maxAvailableVideoZoomFactor
        )

        let zoomFactor = max(
            CameraConstants.minimumZoomFactor,
            min(
                factor,
                maxZoom
            )
        )

        device.videoZoomFactor = zoomFactor

        device.unlockForConfiguration()
    }
    
    func setTorch(enabled: Bool) throws {
        guard
            let device = currentDevice,
            device.hasTorch
        else {
            throw CameraSessionError.cameraUnavailable
        }

        try device.lockForConfiguration()
        defer { device.unlockForConfiguration() }

        if enabled {
            try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
        } else {
            device.torchMode = .off
        }
    }
}
