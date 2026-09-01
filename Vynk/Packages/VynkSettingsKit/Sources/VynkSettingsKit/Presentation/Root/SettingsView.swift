//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem
import VynkChatLists
import VynkQRCodeKit
import VynkPrivacyKit

public struct SettingsView: View {
    @Bindable var store: StoreOf<SettingsFeature>
    
    public init(store: StoreOf<SettingsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(\.path, action: \.path)){
            List {
                Section {
                    UserHeaderView(
                        store: store.scope(
                            \.header,
                             action: \.header
                        )
                    )
                }
                GeneralSectionView(
                    store: store.scope(
                        \.general,
                         action: \.general
                    )
                )
                PreferencesSectionView(
                    store: store.scope(
                        \.preferences,
                         action: \.preferences
                    )
                )
                SupportSectionView(
                    store: store.scope(
                        \.support,
                         action: \.support
                    )
                )
            }
            .background(AppColors.backgroundSecondary)
            .navigationTitle("Settings")
//            .toolbarVisibility(router.tabBarVisiblity, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: AppSymbols.search.name){
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: AppSymbols.qrcode.name){
                        store.send(.qrTapped)
                    }
                }
            }
        } destination: { store in
            switch store.case {
            case .lists(let store):
                ListsView(store: store)
            case .qrCode(let store):
                ProfileQRCodeView(store: store)
            case .privacy(let store):
                PrivacyView(store: store)
            }
        }
    }
}
