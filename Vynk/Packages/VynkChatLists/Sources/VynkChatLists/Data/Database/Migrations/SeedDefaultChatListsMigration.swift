//
//  SeedDefaultChatListsMigration.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import VynkDatabaseKit

struct SeedDefaultChatListsMigration: DatabaseMigration {

    let identifier = "seed_default_chat_lists"
    
    init (){
        print("SeedDefaultChatListsMigration Called")
    }

    func migrate(_ db: VynkDatabase) throws {
        let now = Date()

        try db.execute(
            sql: """
            INSERT INTO chat_lists (
                id,
                kind,
                title,
                sort_order,
                is_visible,
                created_at,
                updated_at
            )
            VALUES
            (?, ?, ?, ?, ?, ?, ?),
            (?, ?, ?, ?, ?, ?, ?),
            (?, ?, ?, ?, ?, ?, ?),
            (?, ?, ?, ?, ?, ?, ?)
            """,
            arguments: [
                .text(DefaultChatListID.favorites),
                .text(ChatListKind.favorites.rawValue),
                .text("Favorites"),
                .integer(0),
                .bool(true),
                .date(now),
                .date(now),

                .text(DefaultChatListID.unread),
                .text(ChatListKind.unread.rawValue),
                .text("Unread"),
                .integer(1),
                .bool(true),
                .date(now),
                .date(now),

                .text(DefaultChatListID.groups),
                .text(ChatListKind.groups.rawValue),
                .text("Groups"),
                .integer(2),
                .bool(true),
                .date(now),
                .date(now),

                .text(DefaultChatListID.communities),
                .text(ChatListKind.communities.rawValue),
                .text("Communities"),
                .integer(3),
                .bool(true),
                .date(now),
                .date(now)
            ]
        )
    }
}
