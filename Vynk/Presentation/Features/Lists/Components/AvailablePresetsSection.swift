//
//  AvailablePresetsSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import SwiftUI

struct AvailablePresetsSection: View {
    let presets: [ChatListRowModel]
    let action: (ChatListRowModel)->()
    var body: some View {
        Section {
            if presets.isEmpty{
                Text("If you remove a preset list like Unread or Groups, it will become available here.")
                    .font(AppFont.caption)
                    .foregroundStyle(AppColors.contentDeemphasized)
                    .padding(.horizontal, AppSpacing.md)
                    .multilineTextAlignment(.center)
            }else{
                ForEach(presets) { preset in
                    HStack {
                        Button("", systemImage: AppIcons.plusFill) {
                            action(preset)
                        }
                        .font(AppFont.subheadline)
                        .tint(AppColors.accent)
                        .foregroundStyle(AppColors.accent)
                        
                        Text(preset.title)
                    }
                }
            }
        } header: {
            Text("Available presets")
        }

    }
}
