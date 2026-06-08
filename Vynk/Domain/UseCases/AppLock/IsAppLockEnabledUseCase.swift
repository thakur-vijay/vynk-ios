//
//  IsAppLockEnabledUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

struct IsAppLockEnabledUseCase {
    private let repository: AppLockRepository

    init(repository: AppLockRepository) {
        self.repository = repository
    }

    func execute() -> Bool {
        repository.isAppLockEnabled()
    }
}
