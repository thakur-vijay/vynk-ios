//
//  ChatListRecordMapper.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

enum ChatListRecordMapper {

   nonisolated static func map(_ record: ChatListRecord) -> ChatList? {

        guard let kind = ChatListKind(rawValue: record.kind) else {

            return nil

        }

        return ChatList(

            id: record.id,

            kind: kind,

            title: record.title,

            sortOrder: record.sortOrder,

            isVisible: record.isVisible,

            createdAt: record.createdAt,

            updatedAt: record.updatedAt

        )

    }

}

