//
//  QRScannerService.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import AVFoundation

@available(iOS 17.0, *)
public final class QRScannerService {

    private let sessionManager: CameraSessionManager

    private let metadataOutput = AVCaptureMetadataOutput()

    private var metadataDelegate: QRScannerMetadataDelegate?

    public init(
        sessionManager: CameraSessionManager
    ) {
        self.sessionManager = sessionManager
    }
    
    public func attachOutput() throws {

        try sessionManager.addOutput(metadataOutput)

        guard metadataOutput.availableMetadataObjectTypes.contains(.qr) else {
            return
        }

        metadataOutput.metadataObjectTypes = [.qr]
    }

    public func detachOutput() {

        metadataOutput.setMetadataObjectsDelegate(
            nil,
            queue: nil
        )

        metadataDelegate = nil

        sessionManager.removeOutput(metadataOutput)
    }

    public func observeQRCode() -> AsyncStream<ScannerResult> {
        AsyncStream { continuation in

            let delegate = QRScannerMetadataDelegate { value in
                continuation.yield(.qrCode(value))
            }

            metadataDelegate = delegate

            metadataOutput.setMetadataObjectsDelegate(
                delegate,
                queue: .main
            )
        }
    }
}
