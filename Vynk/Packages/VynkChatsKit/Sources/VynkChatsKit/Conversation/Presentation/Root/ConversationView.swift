//
//  ChatDetailView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

struct ConversationView: View {
    let store: StoreOf<ConversationFeature>
    
    init(store: StoreOf<ConversationFeature>) {
        self.store = store
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack(spacing: 0) {
                MessagesListUI(sections: store.messageSections, screenWidth: size.width)
                ConversationInputView(
                    store: store.scope(
                        state: \.input,
                        action: \.input
                    )
                )
            }
        }
        .defaultScrollAnchor(.bottom, for: .alignment)
        .background(AppColors.chatBackground)
        .toolbar {
            ConversationHeaderView(
                store: store.scope(
                    \.header,
                     action: \.header
                )
            )
        }
        .navigationTitle(store.model.title)
        .toolbarBackground(AppColors.toolbarBackground, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleDisplayMode(.inline)
    }

}

