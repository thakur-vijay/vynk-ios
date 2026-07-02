//
//  AppButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI

struct AppButton: View {
    let text: String
    var icon: String?
    var foreground: Color = AppColors.accentEmphasized
    var background: Color = AppColors.accentSoftLight
    let action: ()->()
    var body: some View {
        Button(action: action){
            HStack {
                if let icon {
                    Image(systemName: icon)
                }
                Text(text)
            }
            .font(AppFont.headline)
            .foregroundStyle(foreground)
            .fillWidth()
            .padding(.vertical, AppSpacing.lg)
            .background(background, in: .capsule)
        }
        .glassEffect(.regular, in: .capsule)
    }
}
