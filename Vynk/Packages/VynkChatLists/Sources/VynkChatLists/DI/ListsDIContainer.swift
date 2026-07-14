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
    
    private lazy var saveChatListUseCase: SaveChatListUseCase = {
        SaveChatListUseCase(repository: repository)
    }()
    
    private lazy var observeVisibleListsUseCase: ObserveVisibleListsUseCase = {
        ObserveVisibleListsUseCase(repository: repository)
    }()
    
    private lazy var observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase = {
        ObserveAvailablePresetsUseCase(repository: repository)
    }()
    
    private lazy var deleteChatListUseCase: DeleteChatListUseCase = {
        DeleteChatListUseCase(repository: repository)
    }()
    
    private lazy var restorePresetUseCase: RestorePresetListUseCase = {
        RestorePresetListUseCase(repository: repository)
    }()
    
    private lazy var reorderChatListsUseCase: ReorderChatListsUseCase = {
        ReorderChatListsUseCase(repository: repository)
    }()
    
    public func makeObserveVisibleListsUseCase() -> ObserveVisibleListsUseCase {
        observeVisibleListsUseCase
    }
    
    public func makeDeleteListsUseCase() -> DeleteChatListUseCase {
        deleteChatListUseCase
    }
    
    private lazy var client: ChatListsClient = {
        ChatListsClient.live(
            observeVisibleListsUseCase: observeVisibleListsUseCase,
            observeAvailablePresetsUseCase: observeAvailablePresetsUseCase,
            saveChatListUseCase: saveChatListUseCase,
            deleteChatListUseCase: deleteChatListUseCase,
            restorePresetUseCase: restorePresetUseCase,
            reorderChatListsUseCase: reorderChatListsUseCase
        )
    }()
    
    public func register(_ values: inout DependencyValues) {
        values.chatListsClient = client
    }
    
    
    @MainActor public func makeListsView() -> AnyView {
        let store = Store(initialState: ListsFeature.State()) {
            ListsFeature()
        }
        return AnyView(ListsView(
            store: store,
        ))
    }
}
