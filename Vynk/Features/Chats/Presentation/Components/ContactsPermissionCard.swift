//
//  ContactsPermissionCard.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import SwiftUI

struct ContactsPermissionCard: View {
    var onClose: ()->()
    
    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            AppSymbols.warning.image
                .font(AppFont.title1)
                .foregroundStyle(AppColors.yellow)
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("Allow full contact access")
                    .font(AppFont.headline)
                RichTextView(
                    configuration: .init(
                        text: "Make sure you can start new chats with your contacts. Settings",
                        links: [
                            .init(
                                text: "Settings",
                                link: "/settings"
                            )
                        ],
                        linkColor: AppColors.accentSoft
                    )) { _ in
                        
                    }
                    .font(AppFont.body)
            }
            .fillWidth(.leading)
            
            Button(action: onClose){
                AppSymbols.close.image
            }

        }
        .padding(AppSpacing.md)
        .background(AppColors.white, in: .rect(cornerRadius: AppRadius.lg, style: .continuous))
        .clipShape(.rect(cornerRadius: AppRadius.lg, style: .continuous))
        .shadow(color: AppColors.contentDefault.opacity(0.15), radius: 12, x: 0, y: 0)
        .clearListRowStyle()
        .padding()
    }
}
