//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import ComposableArchitecture
import VynkChatLists

public struct ChatsClient: Sendable{

    public var observeVisibleLists:
        @Sendable () -> AsyncThrowingStream<[ChatList], Error>

    public var deleteList:
        @Sendable (ChatList) async throws -> Void

    public init(
        observeVisibleLists: @escaping @Sendable () -> AsyncThrowingStream<[ChatList], Error>,
        deleteList: @escaping @Sendable (ChatList) async throws -> Void
    ) {
        self.observeVisibleLists = observeVisibleLists
        self.deleteList = deleteList
    }
}

extension ChatsClient {

    static func live(
        observeVisibleListsUseCase: ObserveVisibleListsUseCase,
        deleteChatListUseCase: DeleteChatListUseCase
    ) -> Self {

        Self(
            observeVisibleLists: {
                observeVisibleListsUseCase.execute()
            },
            deleteList: { list in
                try await deleteChatListUseCase.execute(list: list)
            }
        )
    }
}

extension ChatsClient: DependencyKey {

    public static let liveValue = Self(
        observeVisibleLists: {
            fatalError("observeVisibleLists not implemented")
        },
        deleteList: { _ in
            fatalError("deleteList not implemented")
        }
    )
}

extension ChatsClient: TestDependencyKey {

    public static let testValue = Self(
        observeVisibleLists: {
            AsyncThrowingStream { continuation in
                continuation.finish()
            }
        },
        deleteList: { _ in }
    )
}

public extension DependencyValues {

    var chatsClient: ChatsClient {
        get { self[ChatsClient.self] }
        set { self[ChatsClient.self] = newValue }
    }
}
