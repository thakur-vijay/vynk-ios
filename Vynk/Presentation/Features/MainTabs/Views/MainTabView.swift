//
//  MainTabView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection: Int = 0
    var body: some View {
        TabView(selection: $selection){
            Tab(value: 0) {
                UpdatesView()
            } label: {
                Label("Updates", systemImage: "circle.dashed")
            }
            Tab(value: 0) {
                CallsView()
            } label: {
                Label("Updates", systemImage: "phone")
            }
            Tab(value: 0) {
                CommunitiesView()
            } label: {
                Label("Updates", systemImage: "person.3")
            }
            Tab(value: 0) {
                ChatsView()
            } label: {
                Label("Updates", systemImage: "message")
            }
            Tab(value: 0) {
                SettingsView()
            } label: {
                Label("Updates", systemImage: "gearshape")
            }
        }
    }
}

#Preview {
    MainTabView()
}
