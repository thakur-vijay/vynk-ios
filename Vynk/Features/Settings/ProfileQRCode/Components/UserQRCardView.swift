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
                    .padding(.vertical, AppSpacing.xl)
            }
            .fillWidth()
            .padding(.top, AppSpacing.lg)
            .padding(.vertical, AppSpacing.xxl)
            .background(AppColors.white, in: .rect(cornerRadius: AppRadius.xl, style: .continuous))
            .overlay(alignment: .top) {
                userImage
                    .offset(y: -(AppAvatarSize.xl/2))
            }
            RichTextView(
                configuration: .init(
                    text: "Your QR code is private. If you share it with someone, they can scan it with their WhatsApp camera to add you as a contact. Learn more",
                    links: [
                        .init(
                            text: "Learn more",
                            link: "/learnMore"
                        )
                    ],
                    linkColor: AppColors.accentSoft,
                    font: AppFont.caption
                )) { _ in
                    
                }
                .foregroundStyle(AppColors.contentDeemphasized)
                .multilineTextAlignment(.center)
        }
        .padding(.top, AppSpacing.xxl)
    }
    
    var userImage: some View {
        Circle()
            .fill(AppColors.white)
            .frame(width: AppAvatarSize.xl, height: AppAvatarSize.xl)
            .overlay {
                GeometryReader{
                    let size = $0.size
                    RemoteImage(
                        url: .init(string: MockImages.avatar),
                        size: size,
                        shape: .circle
                    )
                }
                .padding(4)
            }
    }
}
