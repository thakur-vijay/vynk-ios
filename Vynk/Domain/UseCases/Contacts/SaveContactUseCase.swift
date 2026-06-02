//
//  SaveContactUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

final class SaveContactUseCase {
    let repository: ContactsRepository
    
    init(repository: ContactsRepository) {
        self.repository = repository
    }
    
    func execute(payload: CreateContactPayload)async throws {
        try await repository.saveContact(payload: payload)
    }
}
