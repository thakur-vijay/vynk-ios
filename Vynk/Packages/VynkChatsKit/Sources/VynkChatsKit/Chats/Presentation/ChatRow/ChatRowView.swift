//
//  MessageThreadRowView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import SwiftUI
import VynkDesignSystem
import VynkImage
import ComposableArchitecture

struct ChatRowView: View {

    @Bindable var store: StoreOf<ChatRowFeature>

    var body: some View {
        let model = store.model

        HStack {
            RemoteImage(
                url: URL(string: model.avatarImage),
                size: .init(width: AppAvatarSize.lg, height: AppAvatarSize.lg),
                shape: .circle
            )

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {

                HStack {
                    Text(model.title + (model.isYou ? "(You)" : ""))
                        .font(AppFont.headline)
                        .fillWidth(.leading)

                    Text(model.timestampText)
                        .font(AppFont.subheadline)
                        .foregroundStyle(AppColors.contentDeemphasized)
                }

                HStack(alignment: .top, spacing: AppSpacing.sm) {

                    Text(model.lastMessage)
                        .font(AppFont.subheadline)
                        .foregroundStyle(AppColors.contentDeemphasized)
                        .lineLimit(2)
                        .lineSpacing(1.4)
                        .fillWidth(.leading)

                    if model.unreadCount > 0 {
                        Text("\(model.unreadCount)")
                            .font(AppFont.footnoteMedium)
                            .foregroundStyle(AppColors.white)
                            .padding(.horizontal, AppSpacing.xs)
                            .padding(.vertical, AppSpacing.xxxs)
                            .background(AppColors.accent, in: .capsule)
                    }
                }
            }
            .fillWidth(.leading)
        }
        .frame(height: chatRowHeight)
        .padding(.horizontal, AppSpacing.md)
        .clearListRowStyle(separator: .visible)
        .contentShape(.rect)
        .onTapGesture {
            store.send(.tapped)
        }
        .contextMenu {
            ChatContextMenu(userName: model.title) { action in
                store.send(.contextMenu(action))
            }
        }
        .swipeActions(edge: .leading) {

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
        }
        .swipeActions(edge: .trailing) {

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
