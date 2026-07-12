//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkImage
import VynkDesignSystem

struct UserProfileHeaderView: View {
    let store: StoreOf<UserProfileHeaderFeature>
    
    init(store: StoreOf<UserProfileHeaderFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.md){
            RemoteImage(
                url: .init(string: "https://images.pexels.com/photos/13473569/pexels-photo-13473569.jpeg"),
                size: .init(
                    width: Constants.profileImageSize,
                    height: Constants.profileImageSize
                ),
                shape: .circle
            )
             
            VStack(spacing: AppSpacing.xs){
                Text("Vijay Thakur")
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
