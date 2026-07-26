//
//  SetAppLockEnabledUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

struct SetAppLockEnabledUseCase: Sendable{
    private let repository: AppLockRepository

    init(repository: AppLockRepository) {
        self.repository = repository
    }

    func execute(_ enabled: Bool)async {
        await repository.setAppLockEnabled(enabled)
    }
}
