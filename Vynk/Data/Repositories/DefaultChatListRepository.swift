//
//  DefaultChatListRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import GRDB

final class DefaultChatListRepository: ChatListRepository {
    
    private let dataSource: ChatListLocalDataSource
    
    init(dataSource: ChatListLocalDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchVisibleLists() async throws -> [ChatList] {
        let records = try await dataSource.fetchVisibleLists()
        return records.compactMap { ChatListRecordMapper.map($0) }
    }
    
    func observeVisibleLists() -> AsyncThrowingStream<[ChatList], any Error> {
        AsyncThrowingStream { continuation in

            let cancellable = dataSource.observeVisibleLists(
                onChange: { records in
                    let lists = records.compactMap {
                        ChatListRecordMapper.map($0)
                    }

                    continuation.yield(lists)
                },
                onError: { error in
                    continuation.finish(throwing: error)
                }
            )

            continuation.onTermination = { _ in
                cancellable.cancel()
            }
        }
    }
    
    func observeAvailablePresets()-> AsyncThrowingStream<[ChatList], Error> {

        AsyncThrowingStream { continuation in

            let cancellable = dataSource.observeAvailablePresets(
                onChange: { records in

                    let lists = records.compactMap {
                        ChatListRecordMapper.map($0)
                    }

                    continuation.yield(lists)
                },
                onError: { error in
                    continuation.finish(throwing: error)
                }
            )

            continuation.onTermination = { _ in
                cancellable.cancel()
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
    
    func updateSortOrder(ids: [String]) async throws {
        
    }
    
    
}
