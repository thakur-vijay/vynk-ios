//
//  QRCodeActions.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI

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

