//
//  MessageThreadRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 30/05/26.
//

import SwiftUI

struct MessageThreadRowView: View{
    let model: MessageThreadRowModel
    var body: some View {
        HStack {
            RemoteImage(
                url: .init(string: model.avatarImage),
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
                .padding(.top, AppSpacing.md)

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
                .fillWidth(.top)

                Rectangle()
                    .fill(AppColors.neutralSubtle)
                    .frame(height: 0.5)
            }
            .fillWidth(.leading)
        }
        .frame(height: chatRowHeight)
        .padding(.horizontal, AppSpacing.md)
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
    
    let chatRowHeight: CGFloat = 84
}
