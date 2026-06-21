//
//  ChatListRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import Foundation

protocol ChatListRepository {

    func fetchVisibleLists() async throws -> [ChatList]
    
    func observeVisibleLists() -> AsyncThrowingStream<[ChatList], Error>
    
    func observeAvailablePresets() -> AsyncThrowingStream<[ChatList], Error>
    
    func fetchAvailablePresets() async throws -> [ChatList]

    func createCustomList(
        title: String,
        contactIds: [String]
    ) async throws

    func hidePresetList(
        id: String
    ) async throws
    
    func restorePresetList(id: String) async throws

    func deleteCustomList(
        id: String
    ) async throws

    func updateSortOrder(
        ids: [String]
    ) async throws
}
