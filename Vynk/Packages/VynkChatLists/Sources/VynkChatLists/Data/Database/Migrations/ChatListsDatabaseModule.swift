//
//  ChatListsDatabaseModule.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 03/07/26.
//

import Foundation
import VynkDatabaseKit

public enum ChatListsDatabaseModule: DatabaseModule {

    public static func register(
        on migrator: DatabaseMigrator
    ) {

        migrator.add(CreateChatListsMigration())
        migrator.add(SeedDefaultChatListsMigration())

    }
}
