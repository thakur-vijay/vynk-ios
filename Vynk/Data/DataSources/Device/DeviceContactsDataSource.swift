//
//  DeviceContactsDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation
import Contacts

final class DeviceContactsDataSource {

    private let store = CNContactStore()
    
    func permissionStatus() -> ContactsPermissionStatus {
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
            
        case .notDetermined:
            return .notDetermined
            
        case .restricted:
            return .restricted
            
        case .denied:
            return .denied
            
        case .authorized:
            return .authorized
            
        case .limited:
            return .authorized
            
        @unknown default:
            return .notDetermined
        }
    }
    
    func requestPermission() async throws -> ContactsPermissionStatus {
        
        let granted = try await store.requestAccess(
            for: .contacts
        )
        
        return granted
        ? .authorized
        : .denied
    }
    
    func fetchContacts() async throws -> [DeviceContact]{
        try await Task(priority: .utility) {[store] in
            let keysToFetch: [CNKeyDescriptor] = [
                CNContactIdentifierKey as CNKeyDescriptor,
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor,
                CNContactThumbnailImageDataKey as CNKeyDescriptor
            ]
            
            var contacts: [DeviceContact] = []
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            try store.enumerateContacts(with: request) { contact, _ in
                contacts.append(ContactMapper.map(contact))
            }
            return contacts
        }.value
    }
    
    func saveContact(payload: CreateContactPayload) async throws {
        let contact = CNMutableContact()

        contact.givenName = payload.firstName

        contact.familyName = payload.lastName

        let phone = CNLabeledValue(

            label: CNLabelPhoneNumberMobile,

            value: CNPhoneNumber(stringValue: payload.phoneNumber)

        )

        contact.phoneNumbers = [phone]

        let request = CNSaveRequest()

        request.add(contact, toContainerWithIdentifier: nil)

        try store.execute(request)
    }
}
