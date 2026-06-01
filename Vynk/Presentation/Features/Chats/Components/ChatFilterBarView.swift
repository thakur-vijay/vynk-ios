//
//  ChatFilterBarView.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import SwiftUI


struct ChatFilterBarView: View {
    let list = [
        ChatFilterChipModel(title: "All", isSelected: true),
        ChatFilterChipModel(title: "Unread 4", isSelected: false),
        ChatFilterChipModel(title: "Favourites", isSelected: false),
        ChatFilterChipModel(title: "Groups 1", isSelected: false),
        ChatFilterChipModel(title: "Communities", isSelected: false),
    ]
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppSpacing.xs) {
                ForEach(list) { value in
                    ChatFilterChipView(model: value){
                        
                    }
                    .customContextMenu(actions: [
                    
                    ])
                }
                ChatFilterChipView(model: .init(), icon: AppIcons.plus) {
                    
                }
            }
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .padding([.horizontal, .bottom], AppSpacing.md)
        .padding(.top, AppSpacing.sm)
    }
}

#Preview {
    ChatFilterBarView()
}
