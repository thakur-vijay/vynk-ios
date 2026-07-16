//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 16/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkImage
import VynkDesignSystem

public struct UserHeaderView: View {
    let store: StoreOf<UserHeaderFeature>
    
    init(store: StoreOf<UserHeaderFeature>) {
        self.store = store
    }
    
    public var body: some View {
        HStack {
            RemoteImage(
                url: .init(string: "https://images.pexels.com/photos/13473569/pexels-photo-13473569.jpeg"),
                size: .init(
                    width: AppAvatarSize.lg,
                    height: AppAvatarSize.lg
                ),
                shape: .circle
            )
            
            VStack(alignment: .leading, spacing: AppSpacing.xs){
                Text("Vijay Thakur")
                    .font(AppFont.title2Regular)
                
                Text("This is about")
                    .padding(AppSpacing.sm)
                    .overlay {
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 1.0)
                    }
            }
            .fillWidth(.leading)
        }
    }

}
