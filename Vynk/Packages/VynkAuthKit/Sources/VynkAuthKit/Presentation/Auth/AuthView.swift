//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture

public struct AuthView: View {

    @Bindable var store: StoreOf<AuthFeature>

    public init(store: StoreOf<AuthFeature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            WelcomeView(
                store: store.scope(
                    state: \.welcome,
                    action: \.welcome
                )
            )
        } destination: { store in
            switch store.case {
            case .phoneNumber(let store):
                PhoneNumberView(store: store)
            case .verifyOTP(let store):
                VerifyOTPView(store: store)
            }
        }
    }
}
