//
//  CameraRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
import AVFoundation

protocol CameraRepository {
    func permissionStatus() async -> CameraPermissionStatus
    func requestPermission() async throws -> CameraPermissionStatus

    func configureSession(mode: CameraMode, position: CameraPosition) async throws
    func switchCamera(to position: CameraPosition) async throws
    func startSession() async
    func stopSession() async 
    func capturePhoto() async throws -> CameraOutput

    var session: AVCaptureSession { get }
}
