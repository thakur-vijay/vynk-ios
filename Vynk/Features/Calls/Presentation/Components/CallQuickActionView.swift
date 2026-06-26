//
//  CallQuickActionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import SwiftUI

struct CallQuickActionView: View {
    let icon: String
    let label: String
    let action: ()->()
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .frame(width: AppSizes.avatarLG, height: AppSizes.avatarLG)
                    .background(AppColors.backgroundSecondary, in: .circle)
                Text(label)
                    .font(AppFont.caption)
                    .foregroundStyle(AppColors.contentDeemphasized)
            }
            .contentShape(.rect)
        }
        .hSpacing()
    }
}
