//
//  SwiftUIView.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

public extension VynkDatabase {
    func insert<Record: VynkPersistableRecord>(
        _ record: Record
    ) throws {
        try record.insert(db)
    }

    func insertIgnoringConflict<Record: VynkPersistableRecord>(
        _ record: Record
    ) throws {
        try record.insert(db, onConflict: .ignore)
    }
    
    func insert<Record: VynkPersistableRecord>(
        _ records: [Record]
    ) throws {
        for record in records {
            try record.insert(db)
        }
    }

    func insertIgnoringConflict<Record: VynkPersistableRecord>(
        _ records: [Record]
    ) throws {
        for record in records {
            try record.insert(db, onConflict: .ignore)
        }
    }
}
