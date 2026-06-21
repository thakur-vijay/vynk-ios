//
//  ObserveVisibleListsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

struct ObserveVisibleListsUseCase {

    private let repository: ChatListRepository

    init(repository: ChatListRepository) {
        self.repository = repository
    }

    func execute() -> AsyncThrowingStream<[ChatList], Error> {
        repository.observeVisibleLists()
    }
}
