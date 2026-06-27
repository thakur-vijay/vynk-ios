//
//  VynkDatabaseFilter.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import Foundation

public enum VynkDatabaseFilter: Sendable{
    case equals(VynkColumnName, VynkDatabaseValue)
    case `in`(VynkColumnName, [VynkDatabaseValue])
}

internal extension VynkDatabaseFilter {

    var expression: SQLSpecificExpressible {
        switch self {
        case let .equals(column, value):
            return Column(column.rawValue) == value.databaseValue
        case let .in(column, values):
            return values
                .map(\.databaseValue)
                .contains(Column(column.rawValue))
        }
    }

}
