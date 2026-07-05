//
//  CreateCustomListSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import SwiftUI
import VynkDesignSystem

struct CreateCustomListSection: View {
    let action: ()->()
    var body: some View {
        Section {
            VStack {
                icons
                    .padding(.vertical, AppSpacing.lg)
                Text("Any list you create becomes a filter at the top of your Chats tab.")
                    .foregroundStyle(AppColors.contentDeemphasized)
                    .multilineTextAlignment(.center)
                
                button
            }
            .padding(.top, AppSpacing.lg)
        }
    
    }
    
    var button: some View {
        AppButton(
            text: "Create a custom list",
            icon: AppSymbols.plus.name,
            action: action
        )
    }
    
    var icons: some View {
        let icons = [AppSymbols.Heart.heartFill.name, AppSymbols.bag.name, AppSymbols.plus.name]
        return HStack(spacing: -15){
            ForEach(icons.indices, id: \.self) { index in
                let icon = icons[index]
                iconGroup(icon: icon)
                    .zIndex(-Double(index))
            }
        }
    }
    
    @ViewBuilder
    func iconGroup(icon: String)-> some View {
        ZStack {
            ForEach(0...2, id: \.self) { index in
                iconView(background: index == 2 ? AppColors.accentSoftLight : AppColors.chatBackground)
                    .overlay {
                        if index == 2 {
                            Image(systemName: icon)
                                .font(AppFont.title3)
                                .foregroundStyle(AppColors.accentEmphasized)
                        }
                    }
                    .offset(
                        x: CGFloat(8 * index),
                        y: -CGFloat(8 * index)
                    )
            }
        }
        .frame(width: 80)
    }
    
    @ViewBuilder
    func iconView(background: Color)-> some View {
        Capsule()
            .fill(background)
            .frame(width: 60, height: 40)
            .overlay {
                Capsule()
                    .stroke(AppColors.contentDefault, lineWidth: 2.0)
            }
    }
}
