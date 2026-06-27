//
//  SwiftUIView.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

public extension VynkDatabase {

    func update(
        table: String,
        values: [VynkColumnName: VynkDatabaseValue],
        whereColumn: VynkColumnName,
        equals value: VynkDatabaseValue
    ) throws {

        let assignments = values.keys
            .map { "\($0.rawValue) = ?" }
            .joined(separator: ", ")

        let sql = """
        UPDATE \(table)
        SET \(assignments)
        WHERE \(whereColumn.rawValue) = ?
        """

        let arguments = values.map(\.value) + [value]

        try execute(sql: sql, arguments: arguments)
    }
}
