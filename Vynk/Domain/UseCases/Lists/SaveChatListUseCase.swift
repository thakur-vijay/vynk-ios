//
//  SaveChatListUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

struct SaveChatListUseCase {

    private let repository: ChatListRepository

    init(repository: ChatListRepository) {
        self.repository = repository
    }

    func execute(title: String) async throws {
        let trimmedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedTitle.isEmpty else {
            throw SaveChatListError.emptyTitle
        }

        try await repository.createCustomList(
            title: trimmedTitle,
            contactIds: []
        )
    }
}

enum SaveChatListError: Error {
    case emptyTitle
}
