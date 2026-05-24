//
//  ChatRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct ChatRowView: View{
    let model: ChatRowModel
    var body: some View {
        HStack {
            VynkRemoteImage(
                url: .init(
                    string: model.avatarImage
                ),
                width: AppSizes.avatarLG,
                height: AppSizes.avatarLG,
                shape: .circle
            )
    
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                HStack {
                    Text(model.title + (model.isYou ? "(You)" : ""))
                        .font(AppFont.headline)
                        .hSpacing(.leading)
                    Text(model.timestampText)
                        .font(AppFont.subheadline)
                        .foregroundStyle(AppColors.contentDeemphasized)
                }
                .padding(.top, AppSpacing.smd)

                HStack(alignment: .top, spacing: AppSpacing.sm) {
                    Text(model.lastMessage)
                        .font(AppFont.subheadline)
                        .foregroundStyle(AppColors.contentDeemphasized)
                        .lineLimit(2)
                        .lineSpacing(1.4)
                        .hSpacing(.leading)
                    if model.unreadCount > 0 {
                        Text("\(model.unreadCount)")
                            .font(AppFont.footnoteMedium)
                            .foregroundStyle(AppColors.white)
                            .padding(.horizontal, AppSpacing.xs)
                            .padding(.vertical, AppSpacing.xxxs)
                            .background(AppColors.accent, in: .capsule)
                    }
                }
                .vSpacing(.top)

                Rectangle()
                    .fill(AppColors.neutralSubtle)
                    .frame(height: 0.5)
            }
            .hSpacing(.leading)
        }
        .frame(height: AppSizes.chatRowHeight)
        .padding(.horizontal, AppSpacing.md)
        .swipeActions(edge: .leading) {
            swipeButton(AppIcons.ChatAction.markUnreadSwipe, label: "Unread", tint: AppColors.accentEmphasized) {
                
            }
            swipeButton(AppIcons.pinSlash, label: "Pin", tint: AppColors.neutralMuted) {
                
            }
        }
        .swipeActions(edge: .trailing) {
            swipeButton(AppIcons.ChatAction.archiveSwipe, label: "Archive", tint: AppColors.accentEmphasized) {
                
            }
            
            swipeButton("ellipsis", label: "More", tint: AppColors.neutralMuted) {
                
            }
        }
        .contextMenu {
            Button {
                
            } label: {
                Label("Mark as unread", systemImage: AppIcons.ChatAction.markUnreadMenu)
            }
            
            Button {
                
            } label: {
                Label("Archive", systemImage: AppIcons.ChatAction.archiveMenu)
            }
            
            Button {
                
            } label: {
                Label("Mute", systemImage: AppIcons.bellSlash)
            }
            
            Button {
                
            } label: {
                Label("Lock chat", systemImage: "message")
            }
            
            Button {
                
            } label: {
                Label("Add to Favourites", systemImage: AppIcons.heart)
            }
            
            Button {
                
            } label: {
                Label("Add to list", systemImage: AppIcons.ChatAction.addToListMenu)
            }
            
            Button {
                
            } label: {
                Label("Block User", systemImage: AppIcons.nosign)
            }
            
            Button {
                
            } label: {
                Label("Clear chat", systemImage: AppIcons.xmarkCircle)
            }
            
            Button(role: .destructive) {
                
            } label: {
                Label("Delete Chat", systemImage: AppIcons.trash)
            }

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

#Preview {
    ChatsView()
}
