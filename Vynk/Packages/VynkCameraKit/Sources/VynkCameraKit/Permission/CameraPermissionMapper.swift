//
//  CameraPermissionError.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import AVFoundation

public enum CameraPermissionMapper {

    nonisolated static func map(
        _ status: AVAuthorizationStatus
    ) -> CameraPermissionStatus {
        switch status {
        case .notDetermined:
            return .notDetermined

        case .authorized:
            return .authorized

        case .denied:
            return .denied

        case .restricted:
            return .restricted

        @unknown default:
            return .denied
        }
    }
}
