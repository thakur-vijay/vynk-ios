//
//  ChatListRowModelMapper.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

enum ChatListMapper {

    nonisolated static func map(
        _ list: ChatList
    ) -> ChatListRowModel {

        ChatListRowModel(
            id: list.id,
            title: list.title,
            kind: list.kind,
            canDelete: list.kind.canDelete,
            canEdit: list.kind.canEdit
        )
    }
}

