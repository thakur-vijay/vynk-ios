//
//  ChatFilterChipView.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 04/07/26.
//

import SwiftUI
import VynkDesignSystem

@available(iOS 17.0, *)
struct ChatFilterChipView: View {
    var model: ChatListRowModel?
    var icon: String? = nil
    var onClick: ()->()
    var body: some View {
        Group {
            if let icon {
                Image(systemName: icon)
            }else{
                Text(model?.title ?? "")
            }
        }
        .font(AppFont.captionMedium)
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, icon != nil ? AppSpacing.md : AppSpacing.sm)
        .background((model?.isSelected ?? false) ? AppColors.accentDeemphasized : .white, in: .capsule)
        .overlay {
            Capsule()
                .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 0.5)
        }
        .foregroundStyle((model?.isSelected ?? false) ? AppColors.accentEmphasized : AppColors.contentDeemphasized)
        .contentShape(.rect)
        .onTapGesture(perform: onClick)
        
    }
}
