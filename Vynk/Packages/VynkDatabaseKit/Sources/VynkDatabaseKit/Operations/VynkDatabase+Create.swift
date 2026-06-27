//
//  SwiftUIView.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

public extension VynkDatabase {
    
    func createTable(
        _ name: String,
        ifNotExists: Bool = false,
        body: (VynkTableBuilder) -> Void
    ) throws {
        try db.create(
            table: name,
            ifNotExists: ifNotExists
        ) { table in
            let builder = VynkTableBuilder(table: table)
            body(builder)
        }
    }
}
