//
//  CameraDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI
@preconcurrency import AVFoundation

actor CameraDataSource {

    nonisolated let session = AVCaptureSession()

    private var videoInput: AVCaptureDeviceInput?
    private let photoOutput = AVCapturePhotoOutput()

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
        mode: CameraMode,
        position: CameraPosition
    ) throws {
        session.beginConfiguration()
        defer { session.commitConfiguration() }

        switch mode {
        case .photo:
            session.sessionPreset = .photo
        case .video:
            session.sessionPreset = .high
        }

        session.inputs.forEach {
            session.removeInput($0)
        }

        session.outputs.forEach {
            session.removeOutput($0)
        }

        let input = try makeVideoInput(position: position)

        guard session.canAddInput(input) else {
            throw CameraDataSourceError.unableToAddInput
        }

        session.addInput(input)
        videoInput = input

        guard session.canAddOutput(photoOutput) else {
            throw CameraDataSourceError.unableToAddOutput
        }

        session.addOutput(photoOutput)
    }

    func switchCamera(to position: CameraPosition) throws {
        session.beginConfiguration()
        defer { session.commitConfiguration() }

        if let videoInput {
            session.removeInput(videoInput)
        }

        let input = try makeVideoInput(position: position)

        guard session.canAddInput(input) else {
            throw CameraDataSourceError.unableToAddInput
        }

        session.addInput(input)
        videoInput = input
    }

    func startSession() {
        guard !session.isRunning else { return }
        session.startRunning()
    }

    func stopSession() {
        guard session.isRunning else { return }
        session.stopRunning()
    }

    func capturePhoto() async throws -> CameraOutput {
        throw CameraDataSourceError.captureNotImplemented
    }

    private func makeVideoInput(
        position: CameraPosition
    ) throws -> AVCaptureDeviceInput {
        let devicePosition: AVCaptureDevice.Position

        switch position {
        case .front:
            devicePosition = .front
        case .back:
            devicePosition = .back
        }

        guard let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: devicePosition
        ) else {
            throw CameraDataSourceError.cameraUnavailable
        }

        return try AVCaptureDeviceInput(device: device)
    }

    enum CameraDataSourceError: Error {
        case captureNotImplemented
        case cameraUnavailable
        case unableToAddInput
        case unableToAddOutput
    }
}
