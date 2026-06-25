//
//  PrepareScannerUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation

struct PrepareScannerUseCase {

    private let repository: ScannerRepository

    init(repository: ScannerRepository) {
        self.repository = repository
    }

    func execute() async throws -> CameraPermissionStatus{
       try await repository.prepareScanner()
    }
}
