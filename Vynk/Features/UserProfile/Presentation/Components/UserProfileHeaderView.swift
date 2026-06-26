//
//  UserProfileHeaderView.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import SwiftUI

struct UserProfileHeaderView: View {
    var body: some View {
        let user = MockDataFactory.chats.first
        VStack(spacing: AppSpacing.md){
            VynkRemoteImage(
                url: .init(
                    string: user?.avatarImage ?? ""
                ),
                width: AppSizes.userProfileImageXL,
                height: AppSizes.userProfileImageXL,
                shape: .circle
            )
             
            VStack(spacing: AppSpacing.xs){
                Text(user?.title ?? "")
                    .font(AppFont.title2)
                
                Text("+918146408509")
                    .font(AppFont.subheadline)
                    .foregroundStyle(AppColors.neutralMuted)
            }
        }
        .clearListRowStyle()
        .hSpacing()
        .padding(.bottom, AppSpacing.sm)
    }
}

#Preview {
    UserProfileHeaderView()
}
