//
//  ListsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import SwiftUI

struct ListsView: View {
    @State private var viewModel: ListsViewModel
    @State private var router: ListsRouter
    private let diContainer: ListsDIContainer
    
    init(viewModel: ListsViewModel, router: ListsRouter, container: ListsDIContainer) {
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
        diContainer = container
    }
    
    var body: some View {
        List {
            if viewModel.isCustomListsEmpty{
                CreateCustomListSection {
                    router.presentSheet(.createNewList)
                }
            }
            ListsSection(isCustomListsEmpty: viewModel.isCustomListsEmpty, lists: viewModel.lists) {
                router.presentSheet(.createNewList)
            }
            AvailablePresetsSection(presets: viewModel.availablePresets) { preset in
                Task {
                    await viewModel.restorePreset(id: preset.id)
                }
            }
        }
        .navigationTitle("Lists")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Reorder") {
                    router.presentSheet(.reorderList)
                }
            }
        }
        .sheet(item: .init(get: {
            router.activeSheet
        }, set: { newValue in
            
        }), onDismiss: {
            router.dismissSheet()
        }) { sheet in
            switch sheet {
            case .createNewList:
                diContainer.makeListEditor(mode: .create) {
                    router.dismissSheet()
                }
            case .editList(let listId):
                diContainer.makeListEditor(mode: .edit(id: listId)) {
                    
                }
            case .reorderList:
                diContainer.makeReorderListSheet()
            }
        }
        .task(viewModel.startObserving)
        .onDisappear(perform: viewModel.stopObserving)
    }
}
