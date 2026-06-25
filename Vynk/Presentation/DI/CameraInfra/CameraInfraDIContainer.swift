//
//  CameraInfraDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import SwiftUI

final class CameraInfraDIContainer {

    private lazy var sessionManager: CameraSessionManager = {
        CameraSessionManager()
    }()

    private lazy var photoCaptureService: CameraPhotoCaptureService = {
        CameraPhotoCaptureService(
            sessionManager: sessionManager
        )
    }()

    private lazy var videoRecordingService: CameraVideoRecordingService = {
        CameraVideoRecordingService(
            sessionManager: sessionManager
        )
    }()
    
    private lazy var qrScannerService: QRScannerService = {
        QRScannerService(
            sessionManager: sessionManager
        )
    }()

    lazy var cameraEngine: CameraEngine = {
        CameraEngine(
            sessionManager: sessionManager,
            photoCaptureService: photoCaptureService,
            videoRecordingService: videoRecordingService,
            qrScannerService: qrScannerService
        )
    }()
}
