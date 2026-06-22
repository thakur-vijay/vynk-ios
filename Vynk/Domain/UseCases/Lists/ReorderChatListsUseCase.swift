//
//  ReorderChatListsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

struct ReorderChatListsUseCase {

    private let repository: ChatListRepository

    init(repository: ChatListRepository) {
        self.repository = repository
    }

    func execute(ids: [String]) async throws {
        try await repository.reorderLists(ids: ids)
    }
}
