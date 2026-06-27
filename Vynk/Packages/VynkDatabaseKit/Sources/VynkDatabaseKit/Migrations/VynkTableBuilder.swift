//
//  VynkTableBuilder.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 26/06/26.
//


import GRDB

public final class VynkTableBuilder {

    private let table: TableDefinition

    init(table: TableDefinition) {
        self.table = table
    }

    @discardableResult
    public func text(_ name: String) -> VynkColumnBuilder {
        VynkColumnBuilder(
            column: table.column(name, .text)
        )
    }

    @discardableResult
    public func integer(_ name: String) -> VynkColumnBuilder {
        VynkColumnBuilder(
            column: table.column(name, .integer)
        )
    }

    @discardableResult
    public func boolean(_ name: String) -> VynkColumnBuilder {
        VynkColumnBuilder(
            column: table.column(name, .boolean)
        )
    }

    @discardableResult
    public func datetime(_ name: String) -> VynkColumnBuilder {
        VynkColumnBuilder(
            column: table.column(name, .datetime)
        )
    }

    @discardableResult
    public func blob(_ name: String) -> VynkColumnBuilder {
        VynkColumnBuilder(
            column: table.column(name, .blob)
        )
    }
}