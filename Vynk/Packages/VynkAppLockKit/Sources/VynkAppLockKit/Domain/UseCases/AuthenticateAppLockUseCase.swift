//
//  AuthenticateAppLockUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

struct AuthenticateAppLockUseCase: Sendable{
    private let repository: AppLockRepository

    init(repository: AppLockRepository) {
        self.repository = repository
    }

    func execute() async throws -> Bool {
        try await repository.authenticate()
    }
}
