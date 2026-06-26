//
//  FetchChatListsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

struct FetchVisibleListsUseCase {

    private let repository: ChatListRepository

    init(repository: ChatListRepository) {

        self.repository = repository

    }

    func execute() async throws -> [ChatList] {

        try await repository.fetchVisibleLists()

    }

}
