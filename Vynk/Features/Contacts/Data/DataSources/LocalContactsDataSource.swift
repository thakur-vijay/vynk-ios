//
//  LocalContactsDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation
import GRDB
import VynkDatabaseKit

final class LocalContactsDataSource {
    
    private let database: AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
    
    func fetchContacts() async throws -> [DeviceContact] {
        try await database.dbQueue.read { db in
            
            let records = try ContactRecord
                .order(ContactRecord.Columns.fullName)
                .fetchAll(db)
            
            return records.map {
                
                ContactRecordMapper.toEntity($0)
                
            }
            
        }
    }
    
    func saveContacts(_ contacts: [DeviceContact]) async throws {

        let records = contacts.map {

            ContactRecordMapper.toRecord($0)

        }

        try await database.dbQueue.write { db in

            for record in records {

                try record.insert(db, onConflict: .ignore)

            }

        }

    }

    func fetchSavedNormalizedPhoneNumbers() async throws -> Set<String> {

        try await database.dbQueue.read { db in

            let numbers = try String.fetchAll(

                db,

                sql: """

                SELECT normalized_primary_phone

                FROM device_contacts

                """

            )

            return Set(numbers)

        }

    }
}
