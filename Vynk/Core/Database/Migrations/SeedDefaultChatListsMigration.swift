//
//  SeedDefaultChatListsMigration.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import VynkDatabaseKit
import GRDB

struct SeedDefaultChatListsMigration: DatabaseMigration {
    
    let identifier = "seed_default_chat_lists"
    
    nonisolated func migrate(_ db: Database) throws {
        
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
                DefaultChatListID.favorites,
                ChatListKind.favorites.rawValue,
                "Favorites",
                0,
                true,
                now,
                now,
                
                DefaultChatListID.unread,
                ChatListKind.unread.rawValue,
                "Unread",
                1,
                true,
                now,
                now,
                
                DefaultChatListID.groups,
                ChatListKind.groups.rawValue,
                "Groups",
                2,
                true,
                now,
                now,
                
                DefaultChatListID.communities,
                ChatListKind.communities.rawValue,
                "Communities",
                3,
                true,
                now,
                now
            ]
        )
    }
}
