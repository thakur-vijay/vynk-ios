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
            RemoteImage(
                url: .init(string: user?.avatarImage ?? ""),
                size: .init(
                    width: Constants.profileImageSize,
                    height: Constants.profileImageSize
                ),
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
        .fillWidth()
        .padding(.bottom, AppSpacing.sm)
    }
    
    private enum Constants {

        static let profileImageSize: CGFloat = 120

    }
}

#Preview {
    UserProfileHeaderView()
}
