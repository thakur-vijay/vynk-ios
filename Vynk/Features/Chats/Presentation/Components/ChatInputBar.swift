//
//  ChatInputBar.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import SwiftUI
import VynkFoundation

struct ChatInputBar: View {
    @Binding var message: String
    var onSend: ()->()
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("", text: $message, axis: .vertical)
                .lineLimit(5)
                .padding(.horizontal, AppSpacing.md)
                .frame(minHeight: AppButtonSize.md)
                .tint(AppColors.accent)
                .background(.background, in: .rect(cornerRadius: AppRadius.lg))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 0.7)
                }
            
            if message.isNotBlank {
                Button(action: onSend){
                    AppSymbols.send.image
                        .frame(width: AppButtonSize.md, height: AppButtonSize.md)
                        .background(AppColors.accent, in: .circle)
                }
                .tint(AppColors.white)
            }
        }
        .padding(AppSpacing.md)
        .background(AppColors.chatInputBarBackground)
    }
}
