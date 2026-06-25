//
//  ObserveQRCodeUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//


import Foundation

struct ObserveQRCodeUseCase {

    private let repository: ScannerRepository

    init(repository: ScannerRepository) {
        self.repository = repository
    }

    func execute() -> AsyncStream<ScannerResult> {
        repository.observeQRCode()
    }
}
