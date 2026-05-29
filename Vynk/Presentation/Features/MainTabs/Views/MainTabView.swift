//
//  MainTabView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var activeTab: AnimatedTab = .updates
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppColors.accent)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.accentSoft)
        ]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        AnimatedTabView(selection: $activeTab) {
            Tab.init(AnimatedTab.updates.title, systemImage: AnimatedTab.updates.symbolImage, value: .updates) {
                UpdatesView(viewModel: .init())
            }
            Tab.init(AnimatedTab.calls.title, systemImage: AnimatedTab.calls.symbolImage, value: .calls) {
                CallsView(viewModel: .init())
            }
            Tab.init(AnimatedTab.communities.title, systemImage: AnimatedTab.communities.symbolImage, value: .communities) {
                CommunitiesView()
            }
            Tab.init(AnimatedTab.chats.title, systemImage: AnimatedTab.chats.symbolImage, value: .chats) {
                ChatsView(viewModel: .init())
            }
            Tab.init(AnimatedTab.settings.title, systemImage: AnimatedTab.settings.symbolImage, value: .settings) {
                SettingsView()
            }
        } effects: { tab in
            switch tab {

            case .updates:

                [.pulse]

            case .calls:

                [.bounce.up]

            case .communities:

                [.wiggle]

            case .chats:

                [.bounce.down]

            case .settings:

                [.rotate]

            }
        }
    }
}

#Preview {
    MainTabView()
}
