//
//  CameraActionButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI

struct CameraActionButton: View {
    var icon: String?
    var label: String?
    var size: CGFloat = AppButtonSize.md
    var labelTint: Color = .yellow
    var iconTint: Color = .white
    var background: Color = AppColors.secondarySurface
    var action: ()->Void
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(background)
                .frame(width: size, height: size)
                .overlay {
                    if let icon {
                        Image(systemName: icon)
                            .font(AppFont.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(iconTint)
                    }else {
                        Text(label ?? "")
                            .font(AppFont.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(labelTint)
                    }
                }
        }
    }
}
