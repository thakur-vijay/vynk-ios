//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

public struct UserProfileView: View {
    let store: StoreOf<UserProfileFeature>
    
    public init(store: StoreOf<UserProfileFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List {
            UserProfileHeaderView(
                store: store.scope(
                    \.header,
                     action: \.header
                )
            )
            UserQuickActionView(
                store: store.scope(
                    \.quickActions,
                     action: \.quickActions
                )
            )
            SharedMediaView(
                store: store.scope(
                    \.sharedMedia,
                     action: \.sharedMedia
                )
            )
            ChatCustomizationView(
                store: store.scope(
                    \.chatCustomization,
                     action: \.chatCustomization
                )
            )
            
            ChatPrivacyView(
                store: store.scope(
                    \.chatPrivacy,
                     action: \.chatPrivacy
                )
            )
            
            ContactDetailsView(
                store: store.scope(
                    \.contactDetails,
                     action: \.contactDetails
                )
            )
            
            ContactActionsView(
                store: store.scope(
                    \.contactActions,
                     action: \.contactActions
                )
            )
            
            SafetyView(
                store: store.scope(
                    \.safety,
                     action: \.safety
                )
            )
        }
        .listSectionSpacing(.custom(AppSpacing.lg))
        .background(AppColors.backgroundSecondary)
        .navigationTitle("Contact info")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    
                }
            }
        }
    }
}
