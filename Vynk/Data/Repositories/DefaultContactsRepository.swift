//
//  DefaultContactsRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

final class DefaultContactsRepository: ContactsRepository {
    
    private let dataSource: DeviceContactsDataSource
    
    init(dataSource: DeviceContactsDataSource) {
        self.dataSource = dataSource
    }
    
    func permissionStatus() -> ContactsPermissionStatus {
        dataSource.permissionStatus()
    }
    
    func requestPermission() async throws -> ContactsPermissionStatus {
        try await dataSource.requestPermission()
    }
    
    func fetchContacts() async throws -> [DeviceContact] {
        try await dataSource.fetchContacts()
    }
}
