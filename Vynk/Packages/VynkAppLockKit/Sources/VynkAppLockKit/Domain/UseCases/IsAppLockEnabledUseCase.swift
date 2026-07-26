//
//  IsAppLockEnabledUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

struct IsAppLockEnabledUseCase: Sendable{
    private let repository: AppLockRepository

    init(repository: AppLockRepository) {
        self.repository = repository
    }

    func execute()async -> Bool {
        await repository.isAppLockEnabled()
    }
}
