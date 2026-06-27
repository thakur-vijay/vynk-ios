//
//  DefaultChatListRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

final class DefaultChatListRepository: ChatListRepository {
    
    private let dataSource: ChatListLocalDataSource
    
    init(dataSource: ChatListLocalDataSource) {
        self.dataSource = dataSource
    }
    
    func observeVisibleLists() -> AsyncThrowingStream<[ChatList], Error> {
        AsyncThrowingStream { continuation in

            Task {
                do {
                    for try await records in dataSource.observeVisibleLists() {
                        continuation.yield(
                            records.compactMap(ChatListRecordMapper.map)
                        )
                    }

                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    func observeAvailablePresets()-> AsyncThrowingStream<[ChatList], Error> {
        AsyncThrowingStream { continuation in

            Task {
                do {
                    for try await records in dataSource.observeAvailablePresets() {
                        continuation.yield(
                            records.compactMap(ChatListRecordMapper.map)
                        )
                    }

                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    func fetchAvailablePresets() async throws -> [ChatList] {
        let records = try await dataSource.fetchAvailablePresets()
        return records.compactMap { ChatListRecordMapper.map($0) }
    }
    
    func createCustomList(title: String, contactIds: [String]) async throws {
        try await dataSource.createCustomList(title: title)
    }
    
    func hidePresetList(id: String) async throws {
        try await dataSource.hidePresetList(id: id)
    }
    
    func restorePresetList(id: String) async throws {
        try await dataSource.restorePresetList(id: id)
    }
    
    func deleteCustomList(id: String) async throws {
        try await dataSource.deleteCustomList(id: id)
    }
    
    func reorderLists(ids: [String]) async throws {
        try await dataSource.reorderLists(ids: ids)
    }
    
    
}
