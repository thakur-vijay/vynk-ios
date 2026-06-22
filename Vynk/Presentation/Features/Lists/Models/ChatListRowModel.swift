//
//  ChatListRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

struct ChatListRowModel: Identifiable {

    let id: String
    let title: String
    let kind: ChatListKind

    let canDelete: Bool
    let canEdit: Bool
    let order: Int
    var isSelected: Bool = false
}

extension ChatListRowModel {
    var deleteAlertMessage: String {
        switch kind {
        case .custom:
            return "Your chats with people and groups will not be deleted."
        default: 
            return "Deleting this preset list will hide it from view. Your chats with people and groups won't be deleted. To add this list again, go to Lists in Settings."
        }
    }
}
