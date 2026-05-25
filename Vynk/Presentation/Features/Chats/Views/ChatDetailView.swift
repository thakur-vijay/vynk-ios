//
//  ChatDetailView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI
import Combine
import UIKit

struct ChatDetailView: View {
    private let model: ChatRowModel
    @State private var viewModel: ChatDetailViewModel
    init(model: ChatRowModel, viewModel: ChatDetailViewModel) {
        self.model = model
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            MessagesListUI(sections: messageSections, screenWidth: size.width)
//            ScrollViewReader { scrollProxy in
//                ScrollView {
//                    LazyVStack(spacing: AppSpacing.md) {
//                        ForEach(messageSections) { section in
//                            Text(section.title)
//                                .font(AppFont.footnoteMedium)
//                                .foregroundStyle(AppColors.contentDeemphasized)
//                                .padding(.horizontal, AppSpacing.md)
//                                .padding(.vertical, AppSpacing.xs)
//                                .background(AppColors.background, in: .capsule)
//                            VStack(spacing: AppSpacing.xs) {
//                                ForEach(Array(section.messages.enumerated()), id: \.element.id) { index, message in
//                                    let nextMessage = index < section.messages.count - 1
//                                        ? section.messages[index + 1]
//                                        : nil
//                                    let isLastInGroup =
//                                        nextMessage == nil ||
//                                        nextMessage?.isCurrentUser != message.isCurrentUser
//                                    MessageBubbleView(
//                                        model: message,
//                                        screenWidth: size.width,
//                                        isLast: isLastInGroup
//                                    )
//                                    .id(message.id)
//                                }
//                            }
//                        }
//                    }
//                }
//                .task {
//                    var transation = Transaction()
//                    transation.disablesAnimations = true
//                    withTransaction(transation) {
//                        scrollProxy.scrollTo(messageSections.last?.messages.last?.id, anchor: .bottom)
//                    }
//                }
//            }
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

