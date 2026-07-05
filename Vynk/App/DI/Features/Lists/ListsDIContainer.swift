//
//  ListsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

//import Foundation
//
//final class ListsDIContainer {
//    private let chatListsDIContainer: ChatListsDIContainer
//    
//    init(chatListsDIContainer: ChatListsDIContainer) {
//        self.chatListsDIContainer = chatListsDIContainer
//    }
//
//    func makeListsView() -> ListsView {
//        let viewModel = ListsViewModel(
//            observeVisibleListsUseCase: chatListsDIContainer.observeVisibleListsUseCase,
//            observeAvailablePresetsUseCase: chatListsDIContainer.observeAvailablePresetsUseCase,
//            restorePresetListUseCase: chatListsDIContainer.restorePresetUseCase
//        )
//
//        let router = ListsRouter()
//
//        return ListsView(
//            viewModel: viewModel,
//            router: router,
//            container: self
//        )
//    }
//
//    func makeReorderListSheet() -> ReorderListsView {
//        return chatListsDIContainer.makeReorderListSheet()
//    }
//    
//    func makeListEditor(mode: ListEditorMode, completion: @escaping ()->())-> ListEditor {
//        return chatListsDIContainer.makeListEditor(mode: mode, completion: completion)
//    }
//}
