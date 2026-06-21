//
//  ObserveAvailablePresetsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 22/06/26.
//

import Foundation

struct ObserveAvailablePresetsUseCase {

    private let repository: ChatListRepository

    init(repository: ChatListRepository) {
        self.repository = repository
    }

    func execute() -> AsyncThrowingStream<[ChatList], Error> {

        repository.observeAvailablePresets()
    }
}
