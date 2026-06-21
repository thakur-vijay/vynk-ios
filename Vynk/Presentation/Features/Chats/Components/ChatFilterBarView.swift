//
//  ChatFilterBarView.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import SwiftUI


struct ChatFilterBarView: View {
    let lists: [ChatListRowModel]
    let onClick: (_ id: String)->()
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppSpacing.xs) {
                ChatFilterChipView(
                    model: .init(id: "all", title: "All", kind: .custom, canDelete: false, canEdit: false)
                ) {
                    onClick("all")
                }
                
                ForEach(lists) { list in
                    ChatFilterChipView(model: list){
                        onClick(list.id)
                    }
                    .customContextMenu(actions: [
                    
                    ])
                }
                ChatFilterChipView(icon: AppIcons.plus) {
                    onClick("add")
                }
            }
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .padding([.horizontal, .bottom], AppSpacing.md)
        .padding(.top, AppSpacing.sm)
    }
}
