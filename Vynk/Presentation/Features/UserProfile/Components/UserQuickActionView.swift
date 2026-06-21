//
//  UserQuickActionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 27/05/26.
//

import SwiftUI

struct UserQuickActionView: View {
    var body: some View {
        HStack {
            QuickAction("Audio", symbol: AppIcons.phone)
            QuickAction("Video", symbol: AppIcons.video)
            QuickAction("Pay", symbol: AppIcons.rupee)
            QuickAction("Search", symbol: AppIcons.search)
        }
        .clearListRowStyle()
        .padding(.vertical, AppSpacing.md)
    }
    
    @ViewBuilder
    func QuickAction(_ title: String, symbol: String)-> some View {
        VStack(spacing: AppSpacing.sm) {
            Image(systemName: symbol)
                .foregroundStyle(AppColors.accent)
            Text(title)
                .font(AppFont.caption)
                .foregroundStyle(AppColors.contentDefault)
        }
        .padding(.vertical, AppSpacing.md)
        .hSpacing()
        .background(AppColors.white, in: .rect(cornerRadius: AppRadius.xl, style: .continuous))
    }
}

#Preview {
    UserQuickActionView()
}
