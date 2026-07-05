//
//  RestorePresetListUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 22/06/26.
//

import Foundation

struct RestorePresetListUseCase {

    private let repository: ChatListRepository

    init(repository: ChatListRepository) {
        self.repository = repository
    }

    func execute(id: String) async throws {
        try await repository.restorePresetList(id: id)
    }
}
