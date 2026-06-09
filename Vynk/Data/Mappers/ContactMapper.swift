//
//  ContactMapper.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation
import Contacts

enum ContactMapper {

    nonisolated static func map(
        _ contact: CNContact
    ) -> DeviceContact {

        DeviceContact(
            id: contact.identifier,
            givenName: contact.givenName,
            familyName: contact.familyName,
            fullName: "\(contact.givenName) \(contact.familyName)",
            phoneNumbers: contact.phoneNumbers.map {
                $0.value.stringValue
            },
            thumbnailImageData: contact.thumbnailImageData
        )
    }
}
