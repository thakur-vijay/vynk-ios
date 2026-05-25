//
//  ChatInputBar.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import SwiftUI

struct ChatInputBar: View {
    @State private var text: String = ""
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("", text: $text, axis: .vertical)
                .lineLimit(5)
                .padding(AppSpacing.smd)
                .tint(AppColors.accent)
                .background(.background, in: .rect(cornerRadius: AppRadius.lg))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 0.7)
                }
            
            if text.isNotEmptyString {
                Button {
                    
                } label: {
                    Image(systemName: AppIcons.send)
                        .frame(width: AppSizes.buttonHeightMD, height: AppSizes.buttonHeightMD)
                        .background(AppColors.accent, in: .circle)
                }
                .tint(AppColors.white)
            }
        }
        .padding(AppSpacing.md)
        .background(AppColors.chatInputBarBackground)
    }
}

#Preview {
    ChatInputBar()
}
