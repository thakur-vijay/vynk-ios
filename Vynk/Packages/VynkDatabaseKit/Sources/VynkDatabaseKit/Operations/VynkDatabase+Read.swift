//
//  SwiftUIView.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

import GRDB

public extension VynkDatabase {

    func fetchAll<Record: VynkFetchableRecord & VynkTableRecord>(
        _ record: Record.Type,
        filters: [VynkDatabaseFilter] = [],
        sorting: [VynkDatabaseSort] = []
    ) throws -> [Record] {

        var request = record.all()

        for filter in filters {
            request = request.filter(filter.expression)
        }

        for sort in sorting {
            request = request.order(sort.ordering)
        }

        return try request.fetchAll(db)
    }
    
    func fetchValues<Value: DatabaseValueConvertible>(
        of type: Value.Type,
        from record: (some VynkTableRecord).Type,
        column: VynkColumnName
    ) throws -> [Value] {

        try Value.fetchAll(
            db,
            record.select(
                VynkColumn(column.rawValue)
            )
        )
    }
    
    func fetchMax<Value: DatabaseValueConvertible>(
        _ type: Value.Type,
        column: VynkColumnName,
        from table: String,
        filters: [VynkDatabaseFilter] = []
    ) throws -> Value? {

        var sql = """
        SELECT MAX(\(column.rawValue))
        FROM \(table)
        """

        var arguments: [VynkDatabaseValue] = []

        if !filters.isEmpty {

            sql += " WHERE "

            sql += filters
                .enumerated()
                .map { index, filter in

                    switch filter {

                    case .equals(let column, _):

                        return "\(column.rawValue) = ?"

                    default:
                        fatalError("Not implemented")

                    }

                }
                .joined(separator: " AND ")

            for filter in filters {

                switch filter {

                case .equals(_, let value):
                    arguments.append(value)

                default:
                    break
                }

            }

        }

        return try Value.fetchOne(
            db,
            sql: sql,
            arguments: StatementArguments(
                arguments.map(\.databaseValue)
            )
        )
    }
}

