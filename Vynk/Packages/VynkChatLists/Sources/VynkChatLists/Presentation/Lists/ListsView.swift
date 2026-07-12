//
//  ListsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import SwiftUI
import ComposableArchitecture

@available(iOS 17.0, *)
struct ListsView: View {
    @Bindable var store: StoreOf<ListsFeature>
    
    init(
        store: StoreOf<ListsFeature>,
    ) {
        self.store = store
    }
    
    var body: some View {
        List {
            if store.isCustomListsEmpty{
                CreateCustomListSection {
                    store.send(.createListButtonTapped)
                }
            }
            ListsSection(isCustomListsEmpty: store.isCustomListsEmpty, lists: store.lists) {
                store.send(.createListButtonTapped)
            }
            AvailablePresetsSection(presets: store.availablePresets) { preset in
                store.send(.restorePresetTapped(preset.id))
            }
        }
        .navigationTitle("Lists")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Reorder") {
                    store.send(.reorderButtonTapped)
                }
            }
        }
        .onChange(of: store.destination != nil) { _, value in
            print(value)
        }
        .sheet(
            item: $store.scope(
                state: \.destination,
                action: \.destination
            )
        ) { destinationStore in

            switch destinationStore.state {

            case .listEditor:
                if let store = destinationStore.scope(
                    state: \.listEditor,
                    action: \.listEditor
                ) {
                    ListEditor(store: store)
                }

            case .reorderLists:
                if let store = destinationStore.scope(
                    state: \.reorderLists,
                    action: \.reorderLists
                ) {
                    ReorderListsView(store: store)
                }
            }
        }
        .task {
            await store.send(.onTask).finish()
        }
        .onDisappear {
            store.send(.onDisappear)
        }
    }
}
