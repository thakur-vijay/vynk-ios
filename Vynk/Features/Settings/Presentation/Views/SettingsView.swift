//
//  SettingsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel: SettingsViewModel
    @Bindable private var router: SettingsRouter
    private let diContainer: SettingsDIContainer
    
    init(viewModel: SettingsViewModel, router: SettingsRouter, diContainer: SettingsDIContainer) {
        _viewModel = State(wrappedValue: viewModel)
        _router = Bindable(wrappedValue: router)
        self.diContainer = diContainer
    }
    

    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                userInfo
                ForEach(viewModel.sections) { section in
                    SectionView(section: section) { rowID, kind in
                        if kind == .navigation {
                            router.push(.row(rowID))
                        }
                    }
                }
            }
            .background(AppColors.backgroundSecondary)
            .navigationTitle("Settings")
            .toolbarVisibility(router.tabBarVisiblity, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: AppSymbols.search.name){
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: AppSymbols.qrcode.name){
                        router.push(.profileQRCode)
                    }
                }
            }
            .navigationDestination(for: SettingsRoute.self) { route in
                diContainer.makeDestination(for: route)
            }
        }
        .environment(router)
    }
    
    var userInfo: some View {
        let user = MockDataFactory.chats.first
        return Section {
            Button {
                
            } label: {
                HStack {
                    RemoteImage(
                        url: .init(string: user?.avatarImage ?? ""),
                        size: .init(
                            width: AppAvatarSize.lg,
                            height: AppAvatarSize.lg
                        ),
                        shape: .circle
                    )
                    
                    VStack(alignment: .leading, spacing: AppSpacing.xs){
                        Text("Vijay Thakur")
                            .font(AppFont.title2Regular)
                        
                        Text("This is about")
                            .padding(AppSpacing.sm)
                            .overlay {
                                RoundedRectangle(cornerRadius: AppRadius.md)
                                    .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 1.0)
                            }
                    }
                    .fillWidth(.leading)
                }
            }
            .tint(AppColors.contentDefault)

        }
    }
}
