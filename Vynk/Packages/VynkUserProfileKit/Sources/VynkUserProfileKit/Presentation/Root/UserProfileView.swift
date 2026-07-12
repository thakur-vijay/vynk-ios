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
//            UserProfileHeaderView()
//            UserQuickActionView()
//            ForEach(viewModel.sections) { section in
//                SectionView(section: section) { id, kind in
//                    
//                }
//            }
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
