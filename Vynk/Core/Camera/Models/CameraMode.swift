//
//  CameraMode.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import AVFoundation

enum CameraMode: Sendable {
    case photo
    case video
    case scanner
}

extension CameraMode {

    var sessionPreset: AVCaptureSession.Preset {
        switch self {
        case .photo:
            return .photo

        case .video:
            return .high

        case .scanner:
            return .high
        }
    }
}
