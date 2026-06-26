//
//  UserProfileView.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import SwiftUI

struct UserProfileView: View {
    @State private var viewModel: UserProfileViewModel
    init(viewModel: UserProfileViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    var body: some View {
        List {
            UserProfileHeaderView()
            UserQuickActionView()
            ForEach(viewModel.sections) { section in
                SectionView(section: section) { id, kind in
                    
                }
            }
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
