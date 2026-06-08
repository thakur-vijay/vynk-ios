//
//  DeviceContact.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

struct DeviceContact: Identifiable, Hashable {
    let id: String

    let givenName: String

    let familyName: String

    let fullName: String

    let phoneNumbers: [String]

    let thumbnailImageData: Data?
}
