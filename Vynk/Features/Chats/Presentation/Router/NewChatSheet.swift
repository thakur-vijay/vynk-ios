//
//  NewChatSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import Foundation

enum NewChatSheet: Identifiable {
    case addContact
    case invite(DeviceContact)

    var id: String {
        switch self {
        case .addContact: "addContact"
        case .invite: "invite"
        }
    }
}
