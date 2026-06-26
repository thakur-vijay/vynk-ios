//
//  DatabaseMigrationFactory.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import GRDB

public enum DatabaseMigratorFactory {

    public static func makeMigrator(
        migrations: [DatabaseMigration]
    ) -> DatabaseMigrator {

        var migrator = DatabaseMigrator()

        migrations.forEach { migration in
            migrator.registerMigration(migration.identifier) { db in
                try migration.migrate(db)
            }
        }

        return migrator
    }
}
