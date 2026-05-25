//
//  ChatDetailView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct ChatDetailView: View {
    let model: ChatRowModel
    init(model: ChatRowModel) {
        self.model = model
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView {
                LazyVStack(spacing: AppSpacing.md) {
                    ForEach(messageSections) { section in
                        Text(section.title)
                            .font(AppFont.footnoteMedium)
                            .foregroundStyle(AppColors.contentDeemphasized)
                            .padding(.horizontal, AppSpacing.md)
                            .padding(.vertical, AppSpacing.xs)
                            .background(AppColors.background, in: .capsule)
                        VStack(spacing: AppSpacing.xs) {
                            ForEach(Array(section.messages.enumerated()), id: \.element.id) { index, message in
                                let nextMessage = index < section.messages.count - 1
                                    ? section.messages[index + 1]
                                    : nil
                                let isLastInGroup =
                                    nextMessage == nil ||
                                    nextMessage?.isCurrentUser != message.isCurrentUser
                                MessageBubbleView(
                                    model: message,
                                    screenWidth: size.width,
                                    isLast: isLastInGroup
                                )

                            }
                        }
                    }
                }
            }
        }
        .defaultScrollAnchor(.bottom, for: .initialOffset)
        .background(AppColors.chatBackground)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    VynkRemoteImage(
                        url: .init(string: model.avatarImage),
                        width: AppSizes.avatarMD,
                        height: AppSizes.avatarMD,
                        shape: .circle
                    )
                    VStack(alignment: .leading){
                        Text(model.title)
                        Text("tab here for contact info")
                            .font(AppFont.footnote)
                            .foregroundStyle(AppColors.contentDeemphasized)
                    }
                }
            }
            
            ToolbarSpacer()
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("", systemImage: AppIcons.video) {
                    
                }
                
                Button("", systemImage: AppIcons.phone) {
                    
                }
            }
        }
        .navigationTitle("")
        .toolbarBackground(AppColors.toolbarBackground, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            ChatInputBar()
        }
    }
    
    private var messageSections: [MessageSection] {
        MessageGroupingHelper.groupMessagesByDay(MessageModel.sampleList)
    }
}

