//
//  AppLockView.swift
//  VynkAppLockKit
//
//  Created by Vijay Thakur on 26/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

public struct AppLockView: View {
    let store: StoreOf<AppLockFeature>
    
    public init(store: StoreOf<AppLockFeature>) {
        self.store = store
    }
    
    public var body: some View {
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
                    store.send(.unlockTapped)
                }
        }
        .fillWidth()
        .fillHeight()
        .background(.background)
        .task {
            store.send(.onAppear)
        }
    }
}
