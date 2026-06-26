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
            Image(systemName: AppIcons.lock)
                .font(AppFont.largeTitle.bold())
                .foregroundStyle(AppColors.accent)
            Text("Vynk Locked")
                .font(AppFont.largeTitle.bold())
            
            Button {
                Task {
                    await unlockApp()
                }
            } label: {
                Text("Unlock with Face ID")
                    .font(AppFont.headline)
                    .foregroundStyle(AppColors.contentDefault)
                    .frame(maxWidth: AppSizes.buttonWidth)
                    .padding(.vertical, AppSpacing.md)
                    .background(AppColors.backgroundSecondary, in: .capsule)
                    .overlay {
                        Capsule()
                            .stroke(AppColors.white, lineWidth: 1.0)
                    }
                    .clipShape(.capsule)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 0)
            }

        }
        .hSpacing()
        .vSpacing()
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
