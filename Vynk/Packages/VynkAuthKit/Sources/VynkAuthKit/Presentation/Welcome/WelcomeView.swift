//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import SwiftUI
import ComposableArchitecture

struct WelcomeView: View {
    @Bindable var store: StoreOf<WelcomeFeature>
    init(store: StoreOf<WelcomeFeature>) {
        self.store = store
    }
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            Button("Continue"){
                store.send(.continueButtonTapped)
            }
        } destination: { store in
            switch store.state {
            case .phoneNumber:
                if let store = store.scope(
                    state: \.phoneNumber,
                    action: \.phoneNumber
                ) {
                    Text("Test View")
                }
            }
        }
    }
}
