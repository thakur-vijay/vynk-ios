//
//  AppDatabase.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation
import GRDB

final class AppDatabase {

    let dbQueue: DatabaseQueue

    init(configuration: DatabaseConfiguration = .live) throws {
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
            .makeMigrator()
            .migrate(dbQueue)
        AppLogger.debug(databaseURL, tag: String(describing: self))
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
