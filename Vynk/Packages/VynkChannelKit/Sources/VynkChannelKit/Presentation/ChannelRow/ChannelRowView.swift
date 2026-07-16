//
//  SwiftUIView.swift
//  VynkChannelKit
//
//  Created by Vijay Thakur on 16/07/26.
//

import SwiftUI
import VynkDesignSystem
import VynkImage
import ComposableArchitecture
import VynkMessageThreadKit

public struct ChannelRowView: View {

    @Bindable var store: StoreOf<ChannelRowFeature>
    
    public init(store: StoreOf<ChannelRowFeature>) {
        self.store = store
    }

    public var body: some View {
        let model = store.model
        MessageThreadRowView(model: store.model) {
                store.send(.tapped)
            } contextMenu: {
                ChannelContextMenu(userName: model.title) { action in
                    store.send(.contextMenu(action))
                }
            } leadingSwipeActions: {
                swipeButton(
                    AppSymbols.ChatAction.markUnreadSwipe.name,
                    label: "Unread",
                    tint: AppColors.accentEmphasized
                ) {
                    store.send(.markUnreadTapped)
                }

                swipeButton(
                    AppSymbols.pinSlash.name,
                    label: "Pin",
                    tint: AppColors.neutralMuted
                ) {
                    store.send(.pinTapped)
                }
            } trailingSwipeActions: {
                swipeButton(
                    AppSymbols.ChatAction.archiveSwipe.name,
                    label: "Archive",
                    tint: AppColors.accentEmphasized
                ) {
                    store.send(.archiveTapped)
                }

                swipeButton(
                    "ellipsis",
                    label: "More",
                    tint: AppColors.neutralMuted
                ) {
                    store.send(.moreTapped)
                }
            }
    }

    @ViewBuilder
    private func swipeButton(
        _ icon: String,
        label: String,
        tint: Color,
        action: @escaping () -> Void
    ) -> some View {

        Button(action: action) {
            VStack {
                Image(systemName: icon)
                Text(label)
            }
        }
        .tint(tint)
    }

    private let chatRowHeight: CGFloat = 84
}
