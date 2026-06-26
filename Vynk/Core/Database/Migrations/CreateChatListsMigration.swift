//
//  CreateChatListsMigration.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import GRDB
import VynkDatabaseKit

struct CreateChatListsMigration: DatabaseMigration {

    let identifier = "create_chat_lists"

    nonisolated func migrate(_ db: Database) throws {
        try db.create(table: "chat_lists", ifNotExists: true) { table in
            table.column("id", .text).primaryKey()

            table.column("kind", .text)
                .notNull()

            table.column("title", .text)
                .notNull()

            table.column("sort_order", .integer)
                .notNull()

            table.column("is_visible", .boolean)
                .notNull()

            table.column("created_at", .datetime)
                .notNull()

            table.column("updated_at", .datetime)
                .notNull()
        }
    }
}
