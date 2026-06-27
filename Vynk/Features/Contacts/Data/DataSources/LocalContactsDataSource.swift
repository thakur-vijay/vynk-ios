//
//  LocalContactsDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation
import VynkDatabaseKit

final class LocalContactsDataSource {
    
    private let database: AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
    
    func fetchContacts() async throws -> [DeviceContact] {
        try await database.read { db in
//            let records = try ContactRecord
//                .order(ContactRecord.Columns.fullName)
//                .fetchAll(db)
            let records = try db.fetchAll(
                ContactRecord.self,
                sorting: [.ascending(ContactRecord.ColumnNames.fullName)]
            )
            return records.map {
                ContactRecordMapper.toEntity($0)
            }
        }
    }
    
    func saveContacts(_ contacts: [DeviceContact]) async throws {

        let records = contacts.map {
            ContactRecordMapper.toRecord($0)
        }

        try await database.write { db in

            try db.insertIgnoringConflict(records)
        }

    }

    func fetchSavedNormalizedPhoneNumbers() async throws -> Set<String> {
        try await database.read { db in
            let numbers = try db.fetchValues(
                of: String.self,
                from: ContactRecord.self,
                column: ContactRecord.ColumnNames.normalizedPrimaryPhone
            )
            return Set(numbers)
        }
    }
}

