//
//  QRCodeActions.swift
//  VynkQRCodeKit
//
//  Created by Vijay Thakur on 18/07/26.
//


import SwiftUI
import VynkDesignSystem

struct QRCodeActions: View {
    let scanCode: ()->()
    let resetCode: ()->()
    var body: some View {
        VStack(spacing: AppSpacing.lg){
            AppButton(
                text: "Scan",
                foreground: AppColors.white,
                background: AppColors.accentSoft,
                action: scanCode
            )
            
            Button("Reset QR code"){
                
            }
            .font(AppFont.headline)
            .foregroundStyle(AppColors.accentSoft)
        }
    }
}
