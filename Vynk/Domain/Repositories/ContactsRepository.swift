//
//  ContactsRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

protocol ContactsRepository {
    
    func permissionStatus()async -> ContactsPermissionStatus
    
    func requestPermission() async throws -> ContactsPermissionStatus
    
    func fetchDeviceContacts() async throws -> [DeviceContact]
    
    func saveContactToDevice(payload: CreateContactPayload) async throws
    
    func fetchLocalContacts() async throws -> [DeviceContact]
    
    func saveLocalContacts(_ contacts: [DeviceContact]) async throws
    
    func fetchSavedNormalizedPhoneNumbers() async throws -> Set<String>
}
