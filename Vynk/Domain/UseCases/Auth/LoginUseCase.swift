//
//  LoginUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

struct LoginUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute() async throws {
        try await repository.login()
    }
}
