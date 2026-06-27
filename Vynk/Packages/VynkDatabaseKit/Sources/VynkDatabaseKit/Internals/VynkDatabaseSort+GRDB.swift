//
//  File.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

extension VynkDatabaseSort {

    var ordering: SQLOrderingTerm {

        switch self {

        case .ascending(let column):
            return Column(column.rawValue).asc

        case .descending(let column):
            return Column(column.rawValue).desc

        }

    }

}
