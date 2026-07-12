//
//  ReorderListsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import SwiftUI
import VynkDesignSystem
import ComposableArchitecture

@available(iOS 17.0, *)
struct ReorderListsView: View {
    @Bindable var store: StoreOf<ReorderListsFeature>
    
    init(store: StoreOf<ReorderListsFeature>) {
        self.store = store
    }
    
    var body: some View {
        NavigationStack {
            List {
                EditableListsSection(lists: store.lists.map { ChatListRowModel($0)}) { indexSet, destination in
                    store.send(.move(indexSet, destination))
                } onDeleteRequest: { model in
                    store.send(.deleteButtonTapped(model.id))
                }

                AvailablePresetsSection(presets: store.availablePresets.map { ChatListRowModel($0) }){ preset in
                    store.send(.restorePresetTapped(preset.id))
                }
            }
            .environment(\.editMode, .constant(.active))
            .navigationTitle("Reorder lists")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ProminentToolbarButton(icon: AppSymbols.checkmark.name, accent: AppColors.contentDefault) {
                    store.send(.closeButtonTapped)
                }
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .task {
            await store.send(.onTask).finish()
        }
//        .onDisappear {
//            store.send(.onDisappear)
//        }
    }
}
