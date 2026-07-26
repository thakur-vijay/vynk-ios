//
//  ScannerDIContainer.swift
//  VynkScannerKit
//
//  Created by Vijay Thakur on 25/07/26.
//

import Foundation
import VynkCameraKit
import ComposableArchitecture

public final class ScannerDIContainer {
    
    private let cameraEngine: CameraEngine
    
    public init(cameraEngine: CameraEngine) {
        self.cameraEngine = cameraEngine
    }
    
    private lazy var scannerClient: ScannerClient = {
        let repository = DefaultScannerRepository(cameraEngine: cameraEngine)
        
        let cameraSessionUseCase = CameraSessionUseCase(repository: repository)
        
        let observeQRCodeUseCase = ObserveQRCodeUseCase(repository: repository)
        
        let prepareScannerUseCase = PrepareScannerUseCase(repository: repository)
        
        let stopScannerUseCase = StopScannerUseCase(repository: repository)
        
        let setTorchUseCase = SetTorchUseCase(repository: repository)
        
        return ScannerClient(
            session: cameraSessionUseCase.execute,
            prepareScanner: prepareScannerUseCase.execute,
            observeQRCode: observeQRCodeUseCase.execute,
            stopScanner: stopScannerUseCase.execute,
            setTorch: setTorchUseCase.execute(enabled:)
        )
    }()
    
    public func register(_ values: inout DependencyValues) {
        values.scannerClient = scannerClient
    }
}
