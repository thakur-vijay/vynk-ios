//
//  ScannerClient.swift
//  VynkScannerKit
//
//  Created by Vijay Thakur on 25/07/26.
//

import ComposableArchitecture
import VynkCameraKit
import AVFoundation

public struct ScannerClient: Sendable {
    
    public var session: @Sendable () -> AVCaptureSession

    public var prepareScanner:
        @Sendable () async throws -> CameraPermissionStatus

    public var observeQRCode:
        @Sendable ()async -> AsyncStream<ScannerResult>

    public var stopScanner:
        @Sendable () async -> Void

    public var setTorch:
        @Sendable (_ enabled: Bool) async throws -> Void

    public init(
        session: @escaping @Sendable () -> AVCaptureSession,
        prepareScanner: @escaping @Sendable () async throws -> CameraPermissionStatus,
        observeQRCode: @escaping @Sendable ()async -> AsyncStream<ScannerResult>,
        stopScanner: @escaping @Sendable () async -> Void,
        setTorch: @escaping @Sendable (_ enabled: Bool) async throws -> Void
    ) {
        self.session = session
        self.prepareScanner = prepareScanner
        self.observeQRCode = observeQRCode
        self.stopScanner = stopScanner
        self.setTorch = setTorch
    }
}

extension ScannerClient {

    static func live(
        cameraSessionUseCase: CameraSessionUseCase,
        prepareScannerUseCase: PrepareScannerUseCase,
        observeQRCodeUseCase: ObserveQRCodeUseCase,
        stopScannerUseCase: StopScannerUseCase,
        setTorchUseCase: SetTorchUseCase
    ) -> Self {

        Self(
            session: {
                cameraSessionUseCase.execute()
            },
            prepareScanner: {
                try await prepareScannerUseCase.execute()
            },
            observeQRCode: {
                await observeQRCodeUseCase.execute()
            },
            stopScanner: {
                await stopScannerUseCase.execute()
            },
            setTorch: { enabled in
                try await setTorchUseCase.execute(enabled: enabled)
            }
        )
    }
}

extension ScannerClient: DependencyKey {

    public static let liveValue = Self(
        session: {
            fatalError("session not implemented")
        },
        prepareScanner: {
            fatalError("prepareScanner not implemented")
        },
        observeQRCode: {
            fatalError("observeQRCode not implemented")
        },
        stopScanner: {
            fatalError("stopScanner not implemented")
        },
        setTorch: { _ in
            fatalError("setTorch not implemented")
        }
    )
}

extension ScannerClient: TestDependencyKey {

    public static let testValue = Self(
        session: {
            .init()
        },
        prepareScanner: {
            .authorized
        },
        observeQRCode: {
            AsyncStream { continuation in
                continuation.finish()
            }
        },
        stopScanner: {
        },
        setTorch: { _ in
        }
    )
}

public extension DependencyValues {

    var scannerClient: ScannerClient {
        get { self[ScannerClient.self] }
        set { self[ScannerClient.self] = newValue }
    }
}
