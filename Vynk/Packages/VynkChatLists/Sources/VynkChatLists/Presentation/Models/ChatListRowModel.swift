//
//  ChatListRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

public struct ChatListRowModel: Identifiable, Equatable, Sendable{

    public let id: String
    public let title: String
    public let kind: ChatListKind

    public let canDelete: Bool
    public let canEdit: Bool
    public let order: Int
    public var isSelected: Bool = false
    
    public init(id: String, title: String, kind: ChatListKind, canDelete: Bool, canEdit: Bool, order: Int, isSelected: Bool) {
        self.id = id
        self.title = title
        self.kind = kind
        self.canDelete = canDelete
        self.canEdit = canEdit
        self.order = order
        self.isSelected = isSelected
    }
    
    public init(_ chatList: ChatList) {
        self.init(
            id: chatList.id,
            title: chatList.title,
            kind: chatList.kind,
            canDelete: chatList.kind.canDelete,
            canEdit: chatList.kind.canEdit,
            order: chatList.sortOrder,
            isSelected: false
        )
    }
}

public extension ChatListRowModel {
    var deleteAlertMessage: String {
        switch kind {
        case .custom:
            return "Your chats with people and groups will not be deleted."
        default: 
            return "Deleting this preset list will hide it from view. Your chats with people and groups won't be deleted. To add this list again, go to Lists in Settings."
        }
    }
}
