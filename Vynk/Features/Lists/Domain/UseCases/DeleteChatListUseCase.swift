//
//  DeleteChatListUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

struct DeleteChatListUseCase {
    private let repository: ChatListRepository

    init(repository: ChatListRepository) {
        self.repository = repository
    }

    func execute(list: ChatListRowModel) async throws {
        switch list.kind {
        case .favorites:
            return

        case .unread, .groups, .communities:
            try await repository.hidePresetList(id: list.id)

        case .custom:
            try await repository.deleteCustomList(id: list.id)
        }
    }
}
