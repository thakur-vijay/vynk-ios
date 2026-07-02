//
//  ScannerViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
import AVFoundation
import VynkCameraKit

@LifecycleLogged
@MainActor
@Observable
final class ScannerViewModel {
    let session: AVCaptureSession
    private let observeQRCodeUseCase: ObserveQRCodeUseCase
    private let prepareScannerUseCase: PrepareScannerUseCase
    private let stopScannerUseCase: StopScannerUseCase
    private let setTorchUseCase: SetTorchUseCase
    private var observeQRCodeTask: Task<Void, Never>?
    var onScanCompleted: ((ScannerResult) -> Void)?
    private(set) var selectedFlashMode: CameraFlashMode = .off
    
    init(
        session: AVCaptureSession,
        observeQRCodeUseCase: ObserveQRCodeUseCase,
        prepareScannerUseCase: PrepareScannerUseCase,
        stopScannerUseCase: StopScannerUseCase,
        setTorchUseCase: SetTorchUseCase
    ) {
        self.session = session
        self.observeQRCodeUseCase = observeQRCodeUseCase
        self.prepareScannerUseCase = prepareScannerUseCase
        self.stopScannerUseCase = stopScannerUseCase
        self.setTorchUseCase = setTorchUseCase
    }
    
    func prepareScanner()async{
        do {
            let status = try await prepareScannerUseCase.execute()
            guard status == .authorized else { return }
            startObservingQRCode()
        }catch {
            Log.error(error.localizedDescription)
        }
    }
    
    func stopScanner() async {
        stopObservingQRCode()
        await stopScannerUseCase.execute()
    }
    
    func changeFlashMode()async {
        do {
            if selectedFlashMode == .off {
                selectedFlashMode = .on
                try await setTorchUseCase.execute(enabled: true)
            }else {
                selectedFlashMode = .off
                try await setTorchUseCase.execute(enabled: false)
            }
        }catch {
            
        }
    }
    
    func startObservingQRCode() {

        observeQRCodeTask?.cancel()

        observeQRCodeTask = Task { [weak self] in
            guard let self else { return }

            for await result in observeQRCodeUseCase.execute() {
                Log.info(result, "QRCode")
                observeQRCodeTask?.cancel()
                
                observeQRCodeTask = nil
                
                onScanCompleted?(result)
                
                break
            }
        }
    }
    
    func stopObservingQRCode() {
        observeQRCodeTask?.cancel()
        observeQRCodeTask = nil
    }
}
