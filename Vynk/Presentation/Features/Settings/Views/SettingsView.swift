//
//  SettingsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel: SettingsViewModel = .init()
    var body: some View {
        NavigationStack {
            List {
                userInfo
                ForEach(viewModel.sections.indices, id: \.self) { sectionIndex in
                    Section {
                        ForEach(viewModel.sections[sectionIndex]) { row in
                            NavigationLink(value: row.id) {
                                Label(row.title, systemImage: row.id.symbol ?? "")
                                    .foregroundStyle(AppColors.contentDefault)

                            }

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
            .navigationDestination(for: SettingsRowID.self) { id in
               Text("View")
            }
        }
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
