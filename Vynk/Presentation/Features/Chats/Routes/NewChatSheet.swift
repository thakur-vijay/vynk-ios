//
//  NewChatSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import Foundation

enum NewChatSheet: Identifiable {
    case addContact

    var id: String {
        switch self {
        case .addContact: "addContact"
        }
    }
}
