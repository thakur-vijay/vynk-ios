//
//  ChatListsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import VynkLifecycleMacros

@LifecycleLogged
final class ChatListsDIContainer {
    
    private let database: AppDatabase

    init(database: AppDatabase) {
        self.database = database
    }

    private lazy var dataSource: ChatListLocalDataSource = {
        ChatListLocalDataSource(database: database)
    }()

    private lazy var repository: ChatListRepository = {
        DefaultChatListRepository(dataSource: dataSource)
    }()

    lazy var fetchVisibleListsUseCase: FetchVisibleListsUseCase = {
        FetchVisibleListsUseCase(repository: repository)
    }()

    lazy var fetchAvailablePresetsUseCase: FetchAvailablePresetsUseCase = {
        FetchAvailablePresetsUseCase(repository: repository)
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
    
    func makeReorderListSheet() -> ReorderListsView {
        let viewModel = ReorderListViewModel(
            observeVisibleListsUseCase: observeVisibleListsUseCase,
            observeAvailablePresetsUseCase: observeAvailablePresetsUseCase,
            deleteChatListUseCase: deleteChatListUseCase,
            restorePresetUseCase: restorePresetUseCase,
            reorderChatListsUseCase: reorderChatListsUseCase
        )

        return ReorderListsView(viewModel: viewModel)
    }
    
    func makeListEditor(mode: ListEditorMode, completion: @escaping ()->())-> ListEditor {
        let viewModel = ListEditorViewModel(mode: mode, saveChatListUseCase: saveChatListUseCase)
        return ListEditor(viewModel: viewModel, onClose: completion)
    }
}
