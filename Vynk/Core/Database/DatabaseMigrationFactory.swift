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

        let migrations: [DatabaseMigration] = [

            CreateDeviceContactsMigration(),
            CreateChatListsMigration(),
            SeedDefaultChatListsMigration()

        ]

        migrations.forEach { migration in

            migrator.registerMigration(migration.identifier) { db in

                try migration.migrate(db)

            }

        }

        return migrator

    }

}
