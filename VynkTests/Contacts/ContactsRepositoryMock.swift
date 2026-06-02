//
//  ContactsRepositoryMock.swift
//  VynkTests
//
//  Created by Vijay Thakur on 02/06/26.
//

import Testing
@testable import Vynk

final class ContactsRepositoryMock: ContactsRepository {

    var contacts: [DeviceContact] = []
    var error: Error?

    func permissionStatus() -> ContactsPermissionStatus {
        .authorized
    }

    func requestPermission() async throws -> ContactsPermissionStatus {
        .authorized
    }

    func fetchContacts() async throws -> [DeviceContact] {
        if let error { throw error }
        return contacts
    }
}
