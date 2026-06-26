//
//  DefaultScannerRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import AVFoundation
import VynkCameraKit

final class DefaultScannerRepository: ScannerRepository {
    private let cameraEngine: CameraEngine

    init(cameraEngine: CameraEngine) {
        self.cameraEngine = cameraEngine
    }
    
    var session: AVCaptureSession {
        cameraEngine.session
    }

    func prepareScanner() async throws -> CameraPermissionStatus {
        try await cameraEngine.prepareCamera(
            mode: .scanner,
            position: .back,
            zoomFactor: 1
        )
    }

    func observeQRCode() -> AsyncStream<ScannerResult> {
        cameraEngine.observeQRCode()
    }

    func stopScanner() {
        cameraEngine.stopSession()
    }
    
    func setTorch(enabled: Bool) throws {
        try cameraEngine.setTorch(enabled: enabled)
    }
}
