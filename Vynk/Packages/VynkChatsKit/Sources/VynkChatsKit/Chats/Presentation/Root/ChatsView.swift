//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem
import VynkChatLists
import VynkUserProfileKit

public struct ChatsView: View{
    @Bindable var store: StoreOf<ChatsFeature>
    
    public init(store: StoreOf<ChatsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(\.path, action: \.path)) {
            List {
                ChatFilterBarView(lists: store.lists.map { ChatListRowModel($0) }) { clickedID in
                    store.send(.listTapped(clickedID))
                }
                .clearListRowStyle()
                ForEach(
                    store.scope(
                        state: \.chats,
                        action: \.chats
                    )
                ) { store in
                    ChatRowView(store: store)
                }
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .environment(\.defaultMinListRowHeight, 0)
            .navigationTitle("Chats")
            .toolbar {
                ChatsToolbarContent {
                    store.send(.newChatTapped)
                } onCameraTap: {
                    store.send(.cameraTapped)
                }
            }
            .searchable(text: $store.search, isPresented: $store.isSearchPresented, prompt: Text("Ask Meta Al or Search"))

        } destination: { store in
            switch store.case {
            case .conversation(let store):
                ConversationView(store: store)
            case .userProfile(let store):
                UserProfileView(store: store)
            }
        }
        .sheet(item: $store.scope(state: \.destination, action: \.destination)) { store in
            switch store.case {
            case .listEditor(let store):
                ListEditor(store: store)
            case .reorderLists(let store):
                ReorderListsView(store: store)
            }
        }
        .task {
            await store.send(.onTask).finish()
        }
        .onDisappear {
            store.send(.onDisappear)
        }

    }
    
    @ViewBuilder
    func swipeButton(_ icon: String, label: String, tint: Color, action: ()->())-> some View {
        Button {
            
        } label: {
            VStack {
                Image(systemName: icon)
                Text(label)
            }
        }
        .tint(tint)
        
    }
    
}
