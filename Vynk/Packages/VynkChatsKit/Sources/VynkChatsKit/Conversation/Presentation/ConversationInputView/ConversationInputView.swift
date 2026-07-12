//
//  ChatInputBar.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

struct ConversationInputView: View {
    @Bindable var store: StoreOf<ConversationInputFeature>
    
    init(store: StoreOf<ConversationInputFeature>) {
        self.store = store
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("", text: $store.message, axis: .vertical)
                .lineLimit(5)
                .padding(.horizontal, AppSpacing.md)
                .frame(minHeight: AppButtonSize.md)
                .tint(AppColors.accent)
                .background(.background, in: .rect(cornerRadius: AppRadius.lg))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 0.7)
                }
            
            if store.message.isNotBlank {
                Button {
                    store.send(.sendMessage)
                } label: {
                    AppSymbols.send.image
                        .frame(width: AppButtonSize.md, height: AppButtonSize.md)
                        .background(AppColors.accent, in: .circle)
                }
                .tint(AppColors.white)
            }
        }
        .padding(AppSpacing.md)
        .background(AppColors.chatInputBarBackground)
    }
}
