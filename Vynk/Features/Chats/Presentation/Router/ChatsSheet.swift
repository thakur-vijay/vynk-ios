//
//  ChatSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

enum ChatsSheet: Identifiable {
    case newChat
    case mediaPicker
    case newList
    case reorderList

    var id: String {
        switch self {
        case .newChat: "newChat"
        case .mediaPicker: "mediaPicker"
        case .newList: "newList"
        case .reorderList: "reorderList"
        }
    }
}
