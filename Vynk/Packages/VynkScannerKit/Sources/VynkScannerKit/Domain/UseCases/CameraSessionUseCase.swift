//
//  PrepareScannerUseCase 2.swift
//  VynkScannerKit
//
//  Created by Vijay Thakur on 25/07/26.
//

import AVFoundation

struct CameraSessionUseCase: Sendable{

    private let repository: ScannerRepository

    init(repository: ScannerRepository) {
        self.repository = repository
    }

    func execute() -> AVCaptureSession{
       repository.session
    }
}
