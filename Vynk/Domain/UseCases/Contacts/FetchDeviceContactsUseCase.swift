//
//  FetchDeviceContactsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

final class FetchDeviceContactsUseCase {
    private let repository: ContactsRepository
    
    init(repository: ContactsRepository) {
        self.repository = repository
    }
    
    func execute()async throws -> [DeviceContact] {
        return try await repository.fetchContacts()
    }
}
