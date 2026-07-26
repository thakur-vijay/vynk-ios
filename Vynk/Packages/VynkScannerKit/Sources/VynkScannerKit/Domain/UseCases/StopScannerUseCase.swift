//
//  ScannerUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation

struct StopScannerUseCase {
    private let repository: ScannerRepository

    init(repository: ScannerRepository) {
        self.repository = repository
    }

    @MainActor func execute() async {
        await repository.stopScanner()
    }
}
