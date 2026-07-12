//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkImage
import VynkDesignSystem

struct ConversationHeaderView: ToolbarContent {
    let store: StoreOf<ConversationHeaderFeature>
    
    init(store: StoreOf<ConversationHeaderFeature>) {
        self.store = store
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Button {
                store.send(.openUserDetail)
            } label: {
                HStack {
                    RemoteImage(
                        url: .init(string: store.model.avatarImage),
                        size: .init(
                            width: AppAvatarSize.md,
                            height: AppAvatarSize.md
                        ),
                        shape: .circle
                    )
                    
                    VStack(alignment: .leading){
                        Text(store.model.title)
                        Text("tab here for contact info")
                            .font(AppFont.footnote)
                            .foregroundStyle(AppColors.contentDeemphasized)
                    }
                }
            }

        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button("", systemImage: AppSymbols.video.name) {
                
            }
            
            Button("", systemImage: AppSymbols.phone.name) {
                
            }
        }
    }
}
