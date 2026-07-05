//
//  ChatFilterBarView.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 04/07/26.
//

import SwiftUI
import VynkDesignSystem

@available(iOS 17.0, *)
public struct ChatFilterBarView: View {
    let lists: [ChatListRowModel]
    let onClick: (ChatFilterBarAction) -> Void
    
    public init(lists: [ChatListRowModel], onClick: @escaping (ChatFilterBarAction) -> Void) {
        self.lists = lists
        self.onClick = onClick
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppSpacing.xs) {
                ChatFilterChipView(
                    model: .init(id: "all", title: "All", kind: .custom, canDelete: false, canEdit: false, order: 0, isSelected: false)
                ) {
                    onClick(.all)
                }
                
                ForEach(lists) { list in
                    ChatFilterChipView(model: list){
                        onClick(.list(list))
                    }
                }
                ChatFilterChipView(icon: AppSymbols.plus.name) {
                    onClick(.add)
                }
            }
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .padding([.horizontal, .bottom], AppSpacing.md)
        .padding(.top, AppSpacing.sm)
    }
}
