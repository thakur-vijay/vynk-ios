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
            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    userInfo
                    ForEach(viewModel.sections.indices, id: \.self) { sectionIndex in
                        SectionGroupContainer {
                            ForEach(viewModel.sections[sectionIndex]) { row in
                                SectionRow(
                                    model: row,
                                    showDivider: row.id != viewModel.sections[sectionIndex].last?.id,
                                    onTap: {
                                        
                                    },
                                    leading: {
                                        if let symbol = row.id.symbol {
                                            Image(systemName: symbol)
                                        }
                                    }
                                )

                            }
                            
                        }
                        
                    }
                }
                .padding()
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
        }
    }
    
    var userInfo: some View {
        let user = ChatRowModel.sampleList.first
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
                .padding()
                .contentShape(.rect)
            }
            .buttonStyle(.row)

        }
    }
}
