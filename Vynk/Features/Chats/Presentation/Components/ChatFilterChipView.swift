//
//  ChatFilterChipView.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import SwiftUI
import VynkChatLists

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
