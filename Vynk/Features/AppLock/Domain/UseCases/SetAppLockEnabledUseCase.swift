//
//  SetAppLockEnabledUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

struct SetAppLockEnabledUseCase {
    private let repository: AppLockRepository

    init(repository: AppLockRepository) {
        self.repository = repository
    }

    func execute(_ enabled: Bool) {
        repository.setAppLockEnabled(enabled)
    }
}
