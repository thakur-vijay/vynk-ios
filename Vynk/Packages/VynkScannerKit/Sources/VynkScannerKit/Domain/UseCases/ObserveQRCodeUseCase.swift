//
//  ObserveQRCodeUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//


import Foundation
import VynkCameraKit

struct ObserveQRCodeUseCase {

    private let repository: ScannerRepository

    init(repository: ScannerRepository) {
        self.repository = repository
    }

    func execute()async -> AsyncStream<ScannerResult> {
        await repository.observeQRCode()
    }
}
