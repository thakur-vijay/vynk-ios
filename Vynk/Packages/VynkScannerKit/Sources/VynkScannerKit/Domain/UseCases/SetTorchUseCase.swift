//
//  SetTorchUseCAse.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation

struct SetTorchUseCase {
    private let repository: ScannerRepository

    init(repository: ScannerRepository) {
        self.repository = repository
    }

    @MainActor func execute(enabled: Bool) async throws {
        try await repository.setTorch(enabled: enabled)
    }
}
