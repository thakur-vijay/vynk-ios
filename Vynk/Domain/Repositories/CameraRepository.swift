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
    
    func capturePhoto(flashMode: CameraFlashMode) async throws -> CameraOutput
    
    func startRecording()async throws
    
    func stopRecording() async throws -> CameraOutput
    
    var session: AVCaptureSession { get }
    
}
