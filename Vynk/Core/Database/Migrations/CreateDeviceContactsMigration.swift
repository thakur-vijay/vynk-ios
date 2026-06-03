//
//  CreateDeviceContactsMigration.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import GRDB

struct CreateDeviceContactsMigration: DatabaseMigration {
    
    let identifier = "create_device_contacts"

    func migrate(_ db: Database) throws {
        try db.create(table: "device_contacts", ifNotExists: true) { table in
            table.column("id", .text).primaryKey()
            table.column("full_name", .text).notNull()
            table.column("phone_numbers_json", .blob).notNull()
            table.column("normalized_primary_phone", .text).notNull().unique()
            table.column("thumbnail_image_data", .blob)
        }
    }
}
