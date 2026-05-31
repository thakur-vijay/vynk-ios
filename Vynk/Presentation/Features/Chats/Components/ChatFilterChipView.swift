//
//  ChatFilterChipView.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import SwiftUI

struct ChatFilterChipView: View {
    let model: ChatFilterChipModel
    var icon: String? = nil
    var onClick: ()->()
    var body: some View {
        Group {
            if let icon {
                Image(systemName: icon)
            }else {
                Text(model.title)
            }
        }
        .font(AppFont.captionMedium)
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, icon != nil ? AppSpacing.smd : AppSpacing.sm)
        .background(model.isSelected ? AppColors.accentDeemphasized : .clear, in: .capsule)
        .overlay {
            Capsule()
                .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 0.5)
        }
        .foregroundStyle(model.isSelected ? AppColors.accentEmphasized : AppColors.contentDeemphasized)
        .contentShape(.rect)
        .onTapGesture(perform: onClick)
        
    }
}
