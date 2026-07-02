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
    private let model: MessageThreadRowModel
    var openUserDetail: ()->()
    @State private var viewModel: ChatDetailViewModel
    init(model: MessageThreadRowModel, viewModel: ChatDetailViewModel, openUserDetail: @escaping ()->()) {
        self.model = model
        self.openUserDetail = openUserDetail
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack(spacing: 0) {
                MessagesListUI(sections: viewModel.messageSections, screenWidth: size.width)
                ChatInputBar(message: $viewModel.text) {
                    viewModel.sendMessage()
                }
            }
        }
        .defaultScrollAnchor(.bottom, for: .initialOffset)
        .background(AppColors.chatBackground)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(action: openUserDetail){
                    HStack {
                        VynkRemoteImage(
                            url: .init(string: model.avatarImage),
                            width: AppAvatarSize.md,
                            height: AppAvatarSize.md,
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

            }
            
            ToolbarSpacer()
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("", systemImage: AppSymbols.video.name) {
                    
                }
                
                Button("", systemImage: AppSymbols.phone.name) {
                    
                }
            }
        }
        .navigationTitle(model.title)
        .toolbarBackground(AppColors.toolbarBackground, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleDisplayMode(.inline)
    }

}

