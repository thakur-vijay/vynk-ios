//
//  RequestContactsPermissionUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

final class RequestContactsPermissionUseCase {
    private let repository: ContactsRepository
    
    init(repository: ContactsRepository) {
        self.repository = repository
    }
    
    func execute()async throws -> Bool {
        let status = try await repository.requestPermission()
        return status == .authorized
    }
}
