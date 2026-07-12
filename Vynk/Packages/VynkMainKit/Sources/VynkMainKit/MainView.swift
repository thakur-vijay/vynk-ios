//
//  SwiftUIView.swift
//  VynkMainKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkUpdatesKit
import VynkCallsKit
import VynkCommunitiesKit
import VynkChatsKit
import VynkSettingsKit
import VynkDesignSystem

public struct MainView: View {
    @Bindable var store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppColors.accent)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.accentSoft)
        ]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    public var body: some View {
        TabView(selection: $store.selectedTab) {
            Tab.init(
                AnimatedTab.updates.title,
                systemImage: AnimatedTab.updates.symbolImage,
                value: AnimatedTab.updates
            ) {
                UpdatesView(
                    store: store.scope(
                        \.updates,
                         action: \.updates
                    )
                )
            }
            Tab.init(
                AnimatedTab.calls.title,
                systemImage: AnimatedTab.calls.symbolImage,
                value: AnimatedTab.calls
            ) {
                CallsView(
                    store: store.scope(
                        \.calls,
                         action: \.calls
                    )
                )
            }
            Tab.init(
                AnimatedTab.communities.title,
                systemImage: AnimatedTab.communities.symbolImage,
                value: AnimatedTab.communities
            ) {
                CommunitiesView(
                    store: store.scope(
                        \.communities,
                         action: \.communities
                    )
                )
            }
            Tab.init(
                AnimatedTab.chats.title,
                systemImage: AnimatedTab.chats.symbolImage,
                value: AnimatedTab.chats
            ) {
                ChatsView(
                    store: store.scope(
                        \.chats,
                         action: \.chats
                    )
                )
                .toolbarVisibility(store.chats.prefersTabBarHidden ? .hidden : .visible, for: .tabBar)
            }
            Tab.init(
                AnimatedTab.settings.title,
                systemImage: AnimatedTab.settings.symbolImage,
                value: AnimatedTab.settings
            ) {
                SettingsView(
                    store: store.scope(
                        \.settings,
                         action: \.settings
                    )
                )
            }
        }
    }
}

