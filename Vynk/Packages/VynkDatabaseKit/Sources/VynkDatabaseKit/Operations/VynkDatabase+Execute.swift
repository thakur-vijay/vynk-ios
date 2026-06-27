//
//  SwiftUIView.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

public extension VynkDatabase {
    func execute(
        sql: String,
        arguments: [VynkDatabaseValue] = []
    ) throws {
        try db.execute(
            sql: sql,
            arguments: StatementArguments(
                arguments.map(\.databaseValue)
            )
        )
    }
}
