//
//  UserQuickActionView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

struct UserQuickActionView: View {
    let store: StoreOf<UserQuickActionsFeature>
    
    init(store: StoreOf<UserQuickActionsFeature>) {
        self.store = store
    }
    
    var body: some View {
        HStack {
            QuickAction("Audio", symbol: AppSymbols.phone.name)
            QuickAction("Video", symbol: AppSymbols.video.name)
            QuickAction("Pay", symbol: AppSymbols.rupee.name)
            QuickAction("Search", symbol: AppSymbols.search.name)
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
        .fillWidth()
        .background(AppColors.white, in: .rect(cornerRadius: AppRadius.xl, style: .continuous))
    }
}
