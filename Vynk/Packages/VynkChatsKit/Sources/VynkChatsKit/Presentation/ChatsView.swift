//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture

public struct ChatsView: View {
    let store: StoreOf<ChatsFeature>
    
    public init(store: StoreOf<ChatsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<1000, id: \.self) { i in
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
        }
        .task {
            store.send(.allocateMemory)
        }
        .onDisappear {
            store.send(.releaseMemory)
        }
    }
}
