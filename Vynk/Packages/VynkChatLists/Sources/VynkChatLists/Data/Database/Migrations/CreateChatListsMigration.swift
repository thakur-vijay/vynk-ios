//
//  CreateChatListsMigration.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import VynkDatabaseKit

struct CreateChatListsMigration: DatabaseMigration {

    let identifier = "create_chat_lists"

    func migrate(_ db: VynkDatabase) throws {
        try db.createTable("chat_lists", ifNotExists: true) { table in
            table.text("id").primaryKey()
            table.text("kind").notNull()
            table.text("title").notNull()
            table.integer("sort_order").notNull()
            table.boolean("is_visible").notNull()
            table.datetime("created_at").notNull()
            table.datetime("updated_at").notNull()
        }
    }
}
