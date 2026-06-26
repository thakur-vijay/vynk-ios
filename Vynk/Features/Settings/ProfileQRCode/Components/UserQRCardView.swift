//
//  UserQRCardView.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI

struct UserQRCardView: View {
    let qrContent: String
    var body: some View {
        VStack(spacing: AppSpacing.sm){
            VStack(spacing: AppSpacing.xxs){
                Text("iOS Engineer")
                    .font(AppFont.headline)
                    .fontWeight(.medium)
                Text("Vynk contact")
                    .font(AppFont.subheadline)
                    .foregroundStyle(AppColors.contentDeemphasized)
                QRView(content: qrContent)
                    .padding(.vertical, AppSpacing.xlg)
            }
            .hSpacing()
            .padding(.top, AppSpacing.lg)
            .padding(.vertical, AppSpacing.xxlg)
            .background(AppColors.white, in: .rect(cornerRadius: AppRadius.xl, style: .continuous))
            .overlay(alignment: .top) {
                userImage
                    .offset(y: -(AppSizes.avatarXL/2))
            }
            RichTextView(
                message: "Your QR code is private. If you share it with someone, they can scan it with their WhatsApp camera to add you as a contact. Learn more",
                metadata: ["Learn more": "/learnMore"],
                attributionColor: AppColors.accentSoft) { _ in
                    
                }
                .foregroundStyle(AppColors.contentDeemphasized)
                .multilineTextAlignment(.center)
        }
        .padding(.top, AppSpacing.xxlg)
    }
    
    var userImage: some View {
        Circle()
            .fill(AppColors.white)
            .frame(width: AppSizes.avatarXL, height: AppSizes.avatarXL)
            .overlay {
                GeometryReader{
                    let size = $0.size
                    VynkRemoteImage(
                        url: .init(
                            string: MockImages.avatar
                        ),
                        width: size.width,
                        height: size.height,
                        shape: .circle
                    )
                }
                .padding(4)
            }
    }
}
