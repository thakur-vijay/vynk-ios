//
//  AppButton.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

public struct AppButton: View {
    let text: String
    var icon: String?
    var foreground: Color
    var background: Color
    let action: ()->()
    
    public init(
        text: String,
        icon: String? = nil,
        foreground: Color = AppColors.accentEmphasized,
        background: Color = AppColors.accentSoftLight,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.foreground = foreground
        self.background = background
        self.action = action
    }
    
    public var body: some View {
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
        .buttonStyle(.plain)
        .glassEffect(.capsule)
    }
}
