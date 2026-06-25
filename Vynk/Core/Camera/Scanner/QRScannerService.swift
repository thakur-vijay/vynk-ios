//
//  QRScannerService.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import AVFoundation

final class QRScannerService {

    private let sessionManager: CameraSessionManager

    private let metadataOutput = AVCaptureMetadataOutput()

    private var metadataDelegate: QRScannerMetadataDelegate?

    init(
        sessionManager: CameraSessionManager
    ) {
        self.sessionManager = sessionManager
    }
    
    func attachOutput() throws {

        try sessionManager.addOutput(metadataOutput)

        guard metadataOutput.availableMetadataObjectTypes.contains(.qr) else {
            return
        }

        metadataOutput.metadataObjectTypes = [.qr]
    }

    func detachOutput() {

        metadataOutput.setMetadataObjectsDelegate(
            nil,
            queue: nil
        )

        metadataDelegate = nil

        sessionManager.removeOutput(metadataOutput)
    }

    func observeQRCode() -> AsyncStream<ScannerResult> {
        AsyncStream { continuation in

            let delegate = QRScannerMetadataDelegate { value in
                continuation.yield(.qrCode(value))
            }

            metadataDelegate = delegate

            metadataOutput.setMetadataObjectsDelegate(
                delegate,
                queue: .main
            )

            continuation.onTermination = { [weak self] _ in
                Task { @MainActor in
                    self?.metadataOutput.setMetadataObjectsDelegate(
                        nil,
                        queue: nil
                    )
                    self?.metadataDelegate = nil
                }
            }
        }
    }
}
