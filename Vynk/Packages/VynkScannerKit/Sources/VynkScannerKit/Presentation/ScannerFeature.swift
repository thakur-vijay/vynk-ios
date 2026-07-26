//
//  File.swift
//  VynkScannerKit
//
//  Created by Vijay Thakur on 25/07/26.
//

import ComposableArchitecture
import VynkCameraKit
import AVFoundation

@Reducer
public struct ScannerFeature {

    @Dependency(\.scannerClient)
    private var scannerClient

    @ObservableState
    public struct State: Equatable {
        public var session: AVCaptureSession = .init()
        public var permissionStatus: CameraPermissionStatus = .notDetermined
        public var flashMode: CameraFlashMode = .off
        public var isPreparing = false
        public var isScanning = false

        public init() {}
    }

    public enum Action {
        case task
        case closeTapped
        case flashTapped

        case scannerPrepared(Result<CameraPermissionStatus, Error>)
        case flashModeChanged(CameraFlashMode)
        case qrCodeFound(ScannerResult)
        case stopScanner

        case delegate(Delegate)

        public enum Delegate {
            case scannerResult(ScannerResult)
            case dismiss
        }
    }
    
    private enum CancelID {
        case scannerObservation
    }
    
    public init(){
        
    }

    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            let scannerClient = scannerClient
            switch action {
                
                // MARK: - Lifecycle
                
            case .task:
                state.session = scannerClient.session()
                state.isPreparing = true
                
                return .run { send in
                    do {
                        let status = try await scannerClient.prepareScanner()
                        await send(.scannerPrepared(.success(status)))
                    } catch {
                        await send(.scannerPrepared(.failure(error)))
                    }
                }
                
                // MARK: - Scanner Preparation
                
            case let .scannerPrepared(result):
                state.isPreparing = false
                
                switch result {
                case let .success(status):
                    state.permissionStatus = status
                    
                    guard status == .authorized else {
                        state.isScanning = false
                        return .none
                    }
                    
                    state.isScanning = true
                    
                    return .run { send in
                        for try await result in await scannerClient.observeQRCode() {
                            await send(.qrCodeFound(result))
                            break
                        }
                    }
                    .cancellable(id: CancelID.scannerObservation)
                    
                case .failure:
                    state.isScanning = false
                    return .none
                }
    
            case .flashTapped:
                let shouldEnable = state.flashMode == .off
                
                return .run { send in
                    do {
                        try await scannerClient.setTorch(
                            shouldEnable
                        )
                        
                        await send(
                            .flashModeChanged(
                                shouldEnable ? .on : .off
                            )
                        )
                    } catch {
                        // Keep existing state when torch operation fails.
                    }
                }
                
            case let .flashModeChanged(mode):
                state.flashMode = mode
                return .none

            case .delegate:
                return .none
                
            case let .qrCodeFound(result):
                return .merge(
                    .send(.stopScanner),
                    .send(.delegate(.scannerResult(result)))
                )

            case .closeTapped:
                return .merge(
                    .send(.stopScanner),
                    .send(.delegate(.dismiss))
                )

            case .stopScanner:
                state.isScanning = false

                return .merge(
                    .cancel(id: CancelID.scannerObservation),
                    .run { _ in
                        await scannerClient.stopScanner()
                    }
                )
            }
        }
    }
    
}
