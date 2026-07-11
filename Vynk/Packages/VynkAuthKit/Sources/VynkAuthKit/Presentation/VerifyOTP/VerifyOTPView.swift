//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem
import VynkCountryPicker

struct VerifyOTPView: View {

    @Bindable var store: StoreOf<VerifyOTPFeature>
    
    init(store: StoreOf<VerifyOTPFeature>) {
        self.store = store
    }

    @FocusState
    private var isPhoneFocused: Bool

    var body: some View {

        ScrollView {
            VStack(spacing: AppSpacing.lg){
                Text("Verify your phone number")
                    .font(AppFont.title2.bold())
                    .clearListRowStyle()
                    .fillWidth()
                    .multilineTextAlignment(.center)
                subtitleView("Use your other phone to confirm moving Vynk to this one.")
                subtitleView("Enter the 6-digit code we sent to Vynk on your other phone.")
                
                OTPTextField(value: $store.otp)
                    .onChange(of: store.otp) { _, newValue in
                        if newValue.count == 6 {
                            store.send(.otpCompleted)
                        }
                    }
                
                Button("Didn't receive a verification code?") {
                    
                }
                .font(AppFont.subheadline.bold())
                .foregroundStyle(AppColors.accentSoft)
            }
            .padding(AppSpacing.lg)
        }
        .scrollContentBackground(.hidden)
        .scrollDismissesKeyboard(.interactively)
        .task {
            isPhoneFocused = true
        }
    }
    
    @ViewBuilder
    func subtitleView(_ subtitle: String)-> some View {
        Text(subtitle)
            .clearListRowStyle()
            .font(AppFont.subheadline)
            .foregroundStyle(AppColors.contentDeemphasized)
            .fillWidth()
            .multilineTextAlignment(.center)
    }
    
}
