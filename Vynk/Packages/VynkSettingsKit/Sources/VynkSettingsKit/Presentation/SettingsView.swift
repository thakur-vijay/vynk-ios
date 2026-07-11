//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture

public struct SettingsView: View {
    let store: StoreOf<SettingsFeature>
    
    public init(store: StoreOf<SettingsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Button("Logout") {
            store.send(.logoutTapped)
        }
    }
}
