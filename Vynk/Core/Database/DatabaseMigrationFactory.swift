//
//  DatabaseMigrationFactory.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import GRDB

enum DatabaseMigratorFactory {

    static func makeMigrator() -> DatabaseMigrator {

        var migrator = DatabaseMigrator()

        migrator.registerMigration("create_initial_schema") { db in

            // Empty for now.

            // Later:

            // try db.create(table: "chats") { table in ... }

            // try db.create(table: "messages") { table in ... }

        }

        return migrator

    }

}
