//
//  AppDatabase.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation
import GRDB

public final class AppDatabase {

    public let dbQueue: DatabaseQueue

    public init(
        configuration: DatabaseConfiguration = .live,
        migrations: [DatabaseMigration]
    ) throws {
        let databaseURL = try Self.databaseURL(
            filename: configuration.filename
        )

        var config = GRDB.Configuration()
        config.prepareDatabase { db in
            try db.execute(sql: "PRAGMA foreign_keys = ON")
        }

        self.dbQueue = try DatabaseQueue(
            path: databaseURL.path,
            configuration: config
        )

        try DatabaseMigratorFactory
            .makeMigrator(migrations: migrations)
            .migrate(dbQueue)
    }

    private static func databaseURL(
        filename: String
    ) throws -> URL {
        guard let documentsURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            throw DatabaseError.documentsDirectoryNotFound
        }

        return documentsURL.appendingPathComponent(filename)
    }
}
