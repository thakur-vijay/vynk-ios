//
//  DatabaseInfraDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/06/26.
//

import VynkDatabaseKit

final class DatabaseInfraDIContainer {
    
    lazy var appDatabase: AppDatabase = {
        do {
            return try AppDatabase(migrations: migrations)
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }()
    
    private let migrations: [any DatabaseMigration] = [
        CreateChatListsMigration(),
        CreateDeviceContactsMigration(),
        SeedDefaultChatListsMigration()
    ]
}
