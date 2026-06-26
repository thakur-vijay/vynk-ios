//
//  ScannerDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import VynkCameraKit

final class ScannerDIContainer {
    
    private let cameraEngine: CameraEngine
    
    init(cameraEngine: CameraEngine) {
        self.cameraEngine = cameraEngine
    }
    
    func makeScannerView(result: @escaping (ScannerResult) -> Void)-> ScannerView {
        
        let repository = DefaultScannerRepository(cameraEngine: cameraEngine)
        
        let observeQRCodeUseCase = ObserveQRCodeUseCase(repository: repository)
        
        let prepareScannerUseCase = PrepareScannerUseCase(repository: repository)
        
        let stopScannerUseCase = StopScannerUseCase(repository: repository)
        
        let setTorchUseCase = SetTorchUseCase(repository: repository)
        
        let viewModel = ScannerViewModel(
            session: repository.session,
            observeQRCodeUseCase: observeQRCodeUseCase,
            prepareScannerUseCase: prepareScannerUseCase,
            stopScannerUseCase: stopScannerUseCase,
            setTorchUseCase: setTorchUseCase
        )
        
        return ScannerView(viewModel: viewModel, onDismiss: result)
    }
}
