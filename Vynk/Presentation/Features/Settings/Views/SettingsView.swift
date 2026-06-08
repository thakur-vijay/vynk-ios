//
//  SettingsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel: SettingsViewModel
    @State private var router: SettingsRouter
    private let diContainer: SettingsDIContainer
    
    init(viewModel: SettingsViewModel, router: SettingsRouter, diContainer: SettingsDIContainer) {
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: AppIcons.search){
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: AppIcons.qrcode){
                        
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
        return SectionGroupContainer {
            Button {
                
            } label: {
                HStack {
                    VynkRemoteImage(url: .init(string: user?.avatarImage ?? ""), width: AppSizes.avatarLG, height: AppSizes.avatarLG, shape: .circle)
                    VStack(alignment: .leading, spacing: AppSpacing.xs){
                        Text("Vijay Thakur")
                            .font(AppFont.title2Normal)
                        
                        Text("This is about")
                            .padding(AppSpacing.sm)
                            .overlay {
                                RoundedRectangle(cornerRadius: AppRadius.md)
                                    .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 1.0)
                            }
                    }
                    .hSpacing(.leading)
                }
            }
            .tint(AppColors.contentDefault)

        }
    }
}
