//
//  ObserveVisibleListsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

public struct ObserveVisibleListsUseCase: Sendable{

    private let repository: ChatListRepository

    init(repository: ChatListRepository) {
        self.repository = repository
    }

    public func execute() -> AsyncThrowingStream<[ChatList], Error> {
        repository.observeVisibleLists()
    }
}
