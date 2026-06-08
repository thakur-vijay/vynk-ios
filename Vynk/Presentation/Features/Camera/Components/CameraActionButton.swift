//
//  CameraActionButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI

struct CameraActionButton: View {
    let icon: String
    var size: CGFloat = AppSizes.buttonHeightMD
    let action: ()->Void
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(AppColors.contentDefault.opacity(0.7))
                .frame(width: size, height: size)
                .overlay {
                    Image(systemName: icon)
                        .font(AppFont.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(AppColors.white)
                }
        }
    }
}
