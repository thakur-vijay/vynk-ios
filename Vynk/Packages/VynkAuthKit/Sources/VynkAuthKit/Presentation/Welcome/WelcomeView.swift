//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

struct WelcomeView: View {
    @Bindable var store: StoreOf<WelcomeFeature>
    init(store: StoreOf<WelcomeFeature>) {
        self.store = store
        print("Welcome store created")
    }
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack(spacing: AppSpacing.xl){
                Text("Welcome to Vynk")
                    .font(AppFont.title1.bold())
                
                RichTextView(
                    configuration: .init(
                        text: """
Read our Privacy Policies. Tap "Agree and continue" to accept our Terms of Service.
""",
                        links: [
                            .init(
                                text: "Privacy Policies",
                                link: "/privacyPolicy"
                            ),
                            .init(
                                text: "Terms of Service",
                                link: "/termsOfService"
                            )
                        ],
                        linkColor: AppColors.accentEmphasized,
                        font: AppFont.caption,
                        linkFont: AppFont.captionMedium
                    )
                ) { clickedLink in
                    store.send(.linkTapped(clickedLink))
                }
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    AppColors.contentDeemphasized
                )
                AppButton(
                    text: "Agree and continue",
                    foreground: AppColors.white,
                    background: AppColors.accent
                ) {
                    store.send(.continueButtonTapped)
                }
            }
            .padding(AppSpacing.xxl)
        } destination: { store in
            switch store.case {
            case .phoneNumber(let store):
                PhoneNumberView(store: store)
            case .verifyOPT(let store):
                VerifyOTPView(store: store)
            }
        }
    }
}
