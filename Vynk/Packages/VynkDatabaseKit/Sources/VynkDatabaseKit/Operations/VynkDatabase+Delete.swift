//
//  SwiftUIView.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

public extension VynkDatabase {

    @discardableResult
    func delete<Record: VynkPersistableRecord>(
        _ record: Record.Type,
        key: some VynkDatabaseValueConvertible
    ) throws -> Bool {
        try record.deleteOne(db, key: key)
    }
}
