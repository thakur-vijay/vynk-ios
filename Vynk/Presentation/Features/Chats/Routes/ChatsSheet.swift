//
//  ChatSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

enum ChatsSheet: Identifiable {
    case newChat

    var id: String {
        switch self {
        case .newChat: "newChat"
        }
    }
}
