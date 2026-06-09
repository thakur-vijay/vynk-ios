//
//  DefaultContactsRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

final class DefaultContactsRepository: ContactsRepository {
    
    private let deviceDataSource: DeviceContactsDataSource
    private let localDataSource: LocalContactsDataSource
    
    init(
        deviceDataSource: DeviceContactsDataSource,
        localDataSource: LocalContactsDataSource
    ) {
        self.deviceDataSource = deviceDataSource
        self.localDataSource = localDataSource
    }
    
    func permissionStatus()async -> ContactsPermissionStatus {
        return await deviceDataSource.permissionStatus()
    }
    
    func requestPermission() async throws -> ContactsPermissionStatus {
        try await deviceDataSource.requestPermission()
    }
    
    func fetchDeviceContacts() async throws -> [DeviceContact] {
        try await deviceDataSource.fetchContacts()
    }
    
    func saveContactToDevice(payload: CreateContactPayload) async throws {
        try await deviceDataSource.saveContact(payload: payload)
    }
    
    func fetchLocalContacts() async throws -> [DeviceContact] {
        return try await localDataSource.fetchContacts()
    }
    
    func saveLocalContacts(_ contacts: [DeviceContact]) async throws {
        try await localDataSource.saveContacts(contacts)
    }
    
    func fetchSavedNormalizedPhoneNumbers() async throws -> Set<String> {
        return try await localDataSource.fetchSavedNormalizedPhoneNumbers()
    }
}
