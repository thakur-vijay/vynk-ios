//
//  CreateDeviceContactsMigration.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import VynkDatabaseKit

struct CreateDeviceContactsMigration: DatabaseMigration {
    
    let identifier = "create_device_contacts"

    nonisolated func migrate(_ db: VynkDatabase) throws {
        try db.createTable("device_contacts", ifNotExists: true) { table in
            table.text("id").primaryKey()
            table.text("full_name").notNull()
            table.blob("phone_numbers_json").notNull()
            table.text("normalized_primary_phone").notNull().unique()
            table.blob("thumbnail_image_data")
        }
    }
}
