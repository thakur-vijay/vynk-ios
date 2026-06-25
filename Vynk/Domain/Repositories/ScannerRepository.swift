//
//  ScannerRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import AVFoundation

protocol ScannerRepository {
    var session: AVCaptureSession { get }
    func prepareScanner() async throws -> CameraPermissionStatus
    func observeQRCode() -> AsyncStream<ScannerResult>
    func stopScanner() async
    func setTorch(enabled: Bool) async throws
}
