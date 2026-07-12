//
//  ChatsDIContainer.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import Foundation
import ComposableArchitecture
import VynkChatLists

public final class ChatsDIContainer {
    private let chatListsRouting: ChatListsRouting

    public init(chatListsRouting: ChatListsRouting) {
        self.chatListsRouting = chatListsRouting
    }
    
    public lazy var client: ChatsClient = {
        return ChatsClient(
            observeVisibleLists: chatListsRouting.makeObserveVisibleListsUseCase().execute,
            deleteList: chatListsRouting.makeDeleteListsUseCase().execute(list:)
        )
    }()
}
