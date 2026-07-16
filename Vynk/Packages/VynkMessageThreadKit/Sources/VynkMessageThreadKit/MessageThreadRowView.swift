//
//  MessageThreadRowView.swift
//  VynkMessageThreadKit
//
//  Created by Vijay Thakur on 15/07/26.
//


import SwiftUI
import VynkDesignSystem
import VynkImage

public struct MessageThreadRowView<
    ContextMenuContent: View,
    LeadingSwipeActions: View,
    TrailingSwipeActions: View
>: View {

    private let model: MessageThreadModel

    private let onTap: () -> Void

    @ViewBuilder
    private let contextMenuContent: () -> ContextMenuContent

    @ViewBuilder
    private let leadingSwipeActions: () -> LeadingSwipeActions

    @ViewBuilder
    private let trailingSwipeActions: () -> TrailingSwipeActions

    public init(
        model: MessageThreadModel,
        onTap: @escaping () -> Void = {},
        @ViewBuilder contextMenu: @escaping () -> ContextMenuContent,
        @ViewBuilder leadingSwipeActions: @escaping () -> LeadingSwipeActions,
        @ViewBuilder trailingSwipeActions: @escaping () -> TrailingSwipeActions
    ) {
        self.model = model
        self.onTap = onTap
        self.contextMenuContent = contextMenu
        self.leadingSwipeActions = leadingSwipeActions
        self.trailingSwipeActions = trailingSwipeActions
    }

    public var body: some View {
        HStack {

            RemoteImage(
                url: URL(string: model.avatarImage),
                size: .init(width: AppAvatarSize.lg, height: AppAvatarSize.lg),
                shape: .circle
            )

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {

                HStack {

                    Text(model.title)
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
        .frame(height: 84)
        .padding(.horizontal, AppSpacing.md)
        .clearListRowStyle(separator: .visible)
        .contentShape(.rect)
        .onTapGesture(perform: onTap)
        .contextMenu {
            contextMenuContent()
        }
        .swipeActions(edge: .leading) {
            leadingSwipeActions()
        }
        .swipeActions(edge: .trailing) {
            trailingSwipeActions()
        }
    }
}
