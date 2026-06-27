//
//  ChatListLocalDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import VynkDatabaseKit

final class ChatListLocalDataSource {
    
    private let database: AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
    
    func observeVisibleLists() -> AsyncThrowingStream<[ChatListRecord], Error> {
        
        return database.observeAll(
            ChatListRecord.self,
            filters: [
                .equals(ChatListRecord.ColumnNames.isVisible, .bool(true))
            ],
            sorting: [
                .ascending(ChatListRecord.ColumnNames.sortOrder)
            ]
        )
    }
    
    func observeAvailablePresets() -> AsyncThrowingStream<[ChatListRecord], Error> {

        let presetKinds = ChatListKind.presetKinds.map { VynkDatabaseValue.text($0.rawValue) }
        return database.observeAll(
            ChatListRecord.self,
            filters: [
                .equals(ChatListRecord.ColumnNames.isVisible, .bool(false)),
                .in(ChatListRecord.ColumnNames.kind, presetKinds)
            ],
            sorting: [
                .ascending(ChatListRecord.ColumnNames.sortOrder)
            ]
        )
    }
    
    func fetchAvailablePresets() async throws -> [ChatListRecord] {
        try await database.read { db in
            let presetKinds = ChatListKind.presetKinds.map { VynkDatabaseValue.text($0.rawValue) }
            return try db.fetchAll(
                ChatListRecord.self,
                filters: [
                    .equals(ChatListRecord.ColumnNames.isVisible, .bool(false)),
                    .in(ChatListRecord.ColumnNames.kind, presetKinds)
                ],
                sorting: [.ascending(ChatListRecord.ColumnNames.sortOrder)]
            )
        }
    }
    
    func createCustomList(title: String) async throws {
        try await database.write { db in

            let now = Date()

            let maxSortOrder = try db.fetchMax(
                Int.self,
                column: ChatListRecord.ColumnNames.sortOrder,
                from: ChatListRecord.databaseTableName,
                filters: [
                    .equals(
                        ChatListRecord.ColumnNames.isVisible,
                        .bool(true)
                    )
                ]
            ) ?? -1

            let record = ChatListRecord(
                id: UUID().uuidString,
                kind: ChatListKind.custom.rawValue,
                title: title,
                sortOrder: maxSortOrder + 1,
                isVisible: true,
                createdAt: now,
                updatedAt: now
            )

            try db.insert(record)
        }
    }
    
    func hidePresetList(id: String) async throws {
        try await database.write { db in
            try db.update(
                table: ChatListRecord.databaseTableName,
                values: [
                    ChatListRecord.ColumnNames.isVisible: .bool(false),
                    ChatListRecord.ColumnNames.updatedAt: .date(Date())
                ],
                whereColumn: ChatListRecord.ColumnNames.id,
                equals: .text(id)
            )
        }
    }
    
    func restorePresetList(id: String) async throws {
        try await database.write { db in
            try db.update(
                table: ChatListRecord.databaseTableName,
                values: [
                    ChatListRecord.ColumnNames.isVisible: .bool(true),
                    ChatListRecord.ColumnNames.updatedAt: .date(Date())
                ],
                whereColumn: ChatListRecord.ColumnNames.id,
                equals: .text(id)
            )
        }
    }
    
    func deleteCustomList(id: String) async throws {
    
        try await database.write { db in
            try db.delete(ChatListRecord.self, key: id)
        }
    }
    
    func reorderLists(ids: [String]) async throws {
        try await database.write { db in
            let now = Date()

            for (index, id) in ids.enumerated() {
                try db.update(
                    table: ChatListRecord.databaseTableName,
                    values: [
                        ChatListRecord.ColumnNames.sortOrder: .integer(index),
                        ChatListRecord.ColumnNames.updatedAt: .date(now)
                    ],
                    whereColumn: ChatListRecord.ColumnNames.id,
                    equals: .text(id)
                )
            }
        }
    }
}
