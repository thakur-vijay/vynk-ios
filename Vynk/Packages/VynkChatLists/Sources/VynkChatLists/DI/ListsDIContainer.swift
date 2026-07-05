//
//  ListsDIContainer.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 03/07/26.
//

import VynkDatabaseKit
import SwiftUI
import ComposableArchitecture

@available(iOS 17.0, *)
public final class ListsDIContainer: @MainActor ChatListsRouting{

    private let database: AppDatabase

    public init(database: AppDatabase) {
        self.database = database
    }

    private lazy var dataSource: ChatListLocalDataSource = {
        ChatListLocalDataSource(database: database)
    }()

    private lazy var repository: ChatListRepository = {
        DefaultChatListRepository(dataSource: dataSource)
    }()
    
    lazy var saveChatListUseCase: SaveChatListUseCase = {
        SaveChatListUseCase(repository: repository)
    }()
    
    lazy var observeVisibleListsUseCase: ObserveVisibleListsUseCase = {
        ObserveVisibleListsUseCase(repository: repository)
    }()
    
    lazy var observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase = {
        ObserveAvailablePresetsUseCase(repository: repository)
    }()
    
    lazy var deleteChatListUseCase: DeleteChatListUseCase = {
        DeleteChatListUseCase(repository: repository)
    }()
    
    lazy var restorePresetUseCase: RestorePresetListUseCase = {
        RestorePresetListUseCase(repository: repository)
    }()
    
    lazy var reorderChatListsUseCase: ReorderChatListsUseCase = {
        ReorderChatListsUseCase(repository: repository)
    }()
    
    public func makeObserveVisibleListsUseCase() -> ObserveVisibleListsUseCase {
        observeVisibleListsUseCase
    }
    
    public func makeDeleteListsUseCase() -> DeleteChatListUseCase {
        deleteChatListUseCase
    }
    
    
    
    @MainActor public func makeListsView() -> AnyView {
        let client = ChatListsClient.live(
            observeVisibleListsUseCase: observeVisibleListsUseCase,
            observeAvailablePresetsUseCase: observeAvailablePresetsUseCase,
            saveChatListUseCase: saveChatListUseCase,
            deleteChatListUseCase: deleteChatListUseCase,
            restorePresetUseCase: restorePresetUseCase,
            reorderChatListsUseCase: reorderChatListsUseCase
        )

        let store = Store(initialState: ListsFeature.State()) {
            ListsFeature()
        } withDependencies: {
            $0.chatListsClient = client
        }

        return AnyView(ListsView(
            store: store,
        ))
    }
}
