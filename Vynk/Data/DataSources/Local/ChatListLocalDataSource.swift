//
//  ChatListLocalDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import GRDB

final class ChatListLocalDataSource {
    
    private let database: AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
    
    func fetchVisibleLists() async throws -> [ChatListRecord] {
        try await database.dbQueue.read { db in
            try ChatListRecord
                .filter(Column("is_visible") == true)
                .order(Column("sort_order").asc)
                .fetchAll(db)
        }
    }
    
    func observeVisibleLists(
        onChange: @escaping @Sendable ([ChatListRecord]) -> Void,
        onError: @escaping @Sendable (Error) -> Void
    ) -> DatabaseCancellable {

        let observation = ValueObservation.tracking { db in
            try ChatListRecord
                .filter(Column("is_visible") == true)
                .order(Column("sort_order").asc)
                .fetchAll(db)
        }

        return observation.start(
            in: database.dbQueue,
            scheduling: .mainActor,
            onError: onError,
            onChange: onChange
        )
    }
    
    func observeAvailablePresets(
        onChange: @escaping @Sendable ([ChatListRecord]) -> Void,
        onError: @escaping @Sendable (Error) -> Void
    ) -> DatabaseCancellable {

        let presetKinds = ChatListKind.presetKinds.map(\.rawValue)

        let observation = ValueObservation.tracking { db in
            try ChatListRecord
                .filter(Column("is_visible") == false)
                .filter(
                    presetKinds.contains(Column("kind"))
                )
                .order(Column("sort_order").asc)
                .fetchAll(db)
        }

        return observation.start(
            in: database.dbQueue,
            scheduling: .mainActor,
            onError: onError,
            onChange: onChange
        )
    }
    
    func fetchAvailablePresets() async throws -> [ChatListRecord] {
        try await database.dbQueue.read { db in
            let presetKinds = ChatListKind.presetKinds.map(\.rawValue)
            return try ChatListRecord
                .filter(Column("is_visible") == false)
                .filter(presetKinds.contains(Column("kind")))
                .order(Column("sort_order").asc)
                .fetchAll(db)
        }
    }
    
    func createCustomList(title: String) async throws {
        try await database.dbQueue.write { db in

            let now = Date()

            let maxSortOrder = try Int.fetchOne(
                db,
                sql: "SELECT MAX(sort_order) FROM chat_lists WHERE is_visible = 1"
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

            try record.insert(db)
        }
    }
    
    func hidePresetList(id: String) async throws {
        try await database.dbQueue.write { db in

            try db.execute(
                sql: """
                UPDATE chat_lists
                SET
                    is_visible = 0,
                    updated_at = ?
                WHERE id = ?
                """,
                arguments: [
                    Date(),
                    id
                ]
            )
        }
    }
    
    func restorePresetList(id: String) async throws {
        try await database.dbQueue.write { db in

            try db.execute(
                sql: """
                UPDATE chat_lists
                SET
                    is_visible = 1,
                    updated_at = ?
                WHERE id = ?
                """,
                arguments: [
                    Date(),
                    id
                ]
            )
        }
    }
    
    func deleteCustomList(id: String) async throws {
        try await database.dbQueue.write { db in

            try db.execute(
                sql: """
                DELETE FROM chat_lists
                WHERE id = ?
                """,
                arguments: [id]
            )
        }
    }
    
    func reorderLists(ids: [String]) async throws {
        try await database.dbQueue.write { db in

            for (index, id) in ids.enumerated() {

                try db.execute(
                    sql: """
                    UPDATE chat_lists
                    SET
                        sort_order = ?,
                        updated_at = ?
                    WHERE id = ?
                    """,
                    arguments: [
                        index,
                        Date(),
                        id
                    ]
                )
            }
        }
    }
}
