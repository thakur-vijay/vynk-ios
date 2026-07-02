//
//  AppLockView.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import SwiftUI

struct AppLockView: View {
    @State private var viewModel: AppLockViewModel
    
    init(viewModel: AppLockViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    @Environment(AppLockManager.self)
    private var appLockManager
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            AppSymbols.lock.image
                .font(AppFont.largeTitle.bold())
                .foregroundStyle(AppColors.accent)
            Text("Vynk Locked")
                .font(AppFont.largeTitle.bold())
            
            AppButton(
                text: "Unlock with Face ID",
                foreground: AppColors.contentDefault,
                background: AppColors.backgroundSecondary) {
                    Task {
                        await unlockApp()
                    }
                }
        }
        .fillWidth()
        .fillHeight()
        .background(.background)
        .task {
            await unlockApp()
        }
    }
    
    func unlockApp()async {
        let isUnlocked = await viewModel.unlock()
        if isUnlocked {
            appLockManager.unlock()
        }
    }
}
