//
//  CallQuickActionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import SwiftUI
import VynkDesignSystem

struct CallQuickActionView: View {
    let icon: String
    let label: String
    let action: ()->()
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .frame(width: AppAvatarSize.lg, height: AppAvatarSize.lg)
                    .background(AppColors.backgroundSecondary, in: .circle)
                Text(label)
                    .font(AppFont.caption)
                    .foregroundStyle(AppColors.contentDeemphasized)
            }
            .contentShape(.rect)
        }
        .fillWidth()
    }
}
