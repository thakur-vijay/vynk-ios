//
//  SyncContactsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import Foundation

final class SyncContactsUseCase {

    private let repository: ContactsRepository

    init(repository: ContactsRepository) {
        self.repository = repository
    }

    func sync(
        deviceContacts: [DeviceContact]
    ) async throws {

        let savedPhoneNumbers = try await repository
            .fetchSavedNormalizedPhoneNumbers()

        let newContacts = deviceContacts.filter { contact in

            guard let firstPhone = contact.phoneNumbers.first else {
                return false
            }

            let normalizedPhone = normalizePhoneNumber(
                firstPhone
            )

            return !savedPhoneNumbers.contains(
                normalizedPhone
            )
        }

        guard !newContacts.isEmpty else {
            return
        }

        try await repository.saveLocalContacts(
            newContacts
        )
    }
    
    func fetchLocalContacts() async throws -> [DeviceContact] {
        try await repository.fetchLocalContacts()
        
    }

    private func normalizePhoneNumber(
        _ phoneNumber: String
    ) -> String {

        let digits = phoneNumber.filter(\.isNumber)

        if digits.count > 10 {
            return String(digits.suffix(10))
        }

        return digits
    }
}
