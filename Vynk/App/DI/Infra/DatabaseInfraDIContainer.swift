//
//  DatabaseInfraDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/06/26.
//

import VynkDatabaseKit
import VynkChatLists

final class DatabaseInfraDIContainer {
    
    lazy var appDatabase: AppDatabase = {
        do {
            let migrator = DatabaseMigrator()
            migrator.register(ChatListsDatabaseModule.self)

            let database = try AppDatabase(
                migrator: migrator
            )
            return database
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }()
}
