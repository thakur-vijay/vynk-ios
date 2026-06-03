//
//  ContactsPermissionUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import Foundation

final class ContactsPermissionUseCase {
    private let repository: ContactsRepository
    init(repository: ContactsRepository) {
        self.repository = repository
    }

    func status() -> ContactsPermissionStatus {
        return repository.permissionStatus()
    }

    func request() async throws -> Bool {
        let status = try await repository.requestPermission()
        return status == .authorized
    }
}
