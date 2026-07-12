//
//  ChatListsClient.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 05/07/26.
//

import ComposableArchitecture

struct ChatListsClient {

    var observeVisibleLists:
        @Sendable () -> AsyncThrowingStream<[ChatList], Error>

    var observeAvailablePresets:
        @Sendable () -> AsyncThrowingStream<[ChatList], Error>

    var save:
        @Sendable (String) async throws -> Void

    var restorePreset:
        @Sendable (String) async throws -> Void

    var delete:
        @Sendable (ChatList) async throws -> Void

    var reorder:
        @Sendable ([String]) async throws -> Void
}

extension ChatListsClient {

    static func live(
        observeVisibleListsUseCase: ObserveVisibleListsUseCase,
        observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase,
        saveChatListUseCase: SaveChatListUseCase,
        deleteChatListUseCase: DeleteChatListUseCase,
        restorePresetUseCase: RestorePresetListUseCase,
        reorderChatListsUseCase: ReorderChatListsUseCase
    ) -> Self {

        Self(
            observeVisibleLists: {
                observeVisibleListsUseCase.execute()
            },

            observeAvailablePresets: {
                observeAvailablePresetsUseCase.execute()
            },

            save: { title in
                try await saveChatListUseCase.execute(title: title)
            },

            restorePreset: { id in
                try await restorePresetUseCase.execute(id: id)
            },

            delete: { model in
                try await deleteChatListUseCase.execute(list: model)
            },

            reorder: { ids in
                try await reorderChatListsUseCase.execute(ids: ids)
            }
        )
    }
}

extension ChatListsClient: DependencyKey {

    static let liveValue = Self(
        observeVisibleLists: {
            fatalError("Unimplemented")
        },

        observeAvailablePresets: {
            fatalError("Unimplemented")
        },

        save: { _ in
            fatalError("Unimplemented")
        },

        restorePreset: { _ in
            fatalError("Unimplemented")
        },

        delete: { _ in
            fatalError("Unimplemented")
        },

        reorder: { _ in
            fatalError("Unimplemented")
        }
    )
    
}

extension ChatListsClient: TestDependencyKey {

    static let testValue = Self(
        observeVisibleLists: {
            AsyncThrowingStream { continuation in
                continuation.finish()
            }
        },
        observeAvailablePresets: {
            AsyncThrowingStream { continuation in
                continuation.finish()
            }
        },
        save: { _ in },
        restorePreset: { _ in },
        delete: { _ in },
        reorder: { _ in }
    )
}

extension DependencyValues {

    var chatListsClient: ChatListsClient {
        get { self[ChatListsClient.self] }
        set { self[ChatListsClient.self] = newValue }
    }
}
