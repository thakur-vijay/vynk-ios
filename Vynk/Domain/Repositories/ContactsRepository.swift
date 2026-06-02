//
//  ContactsRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

protocol ContactsRepository {
    
    func permissionStatus() -> ContactsPermissionStatus
    
    func requestPermission() async throws -> ContactsPermissionStatus
    
    func fetchContacts() async throws -> [DeviceContact]
    
    func saveContact(payload: CreateContactPayload) async throws
}
