//
//  QRScannerMetadataDelegate.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import AVFoundation

final class QRScannerMetadataDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {

    private let onCodeDetected: (String) -> Void

    init(
        onCodeDetected: @escaping (String) -> Void
    ) {
        self.onCodeDetected = onCodeDetected
    }

    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard
            let metadataObject = metadataObjects
                .compactMap({ $0 as? AVMetadataMachineReadableCodeObject })
                .first(where: { $0.type == .qr }),
            let value = metadataObject.stringValue
        else {
            return
        }

        onCodeDetected(value)
    }
}
