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
        ScrollView {
            VStack(spacing: AppSpacing.lg) {
                UserProfileHeaderView()
                UserQuickActionView()
                ForEach(viewModel.sections.indices, id: \.self) { sectionIndex in
                    SectionGroupContainer {
                        ForEach(viewModel.sections[sectionIndex]) { row in
                            SectionRow(
                                model: row,
                                showDivider: row.id != viewModel.sections[sectionIndex].last?.id,
                                onTap: {
                                    
                                },
                                leading: {
                                    if let symbol = row.id.symbol {
                                        Image(systemName: symbol)
                                    }
                                }
                            )

                        }
                        
                    }
                    
                }
            }
            .padding()
        }
        .listSectionSpacing(AppSpacing.lg)
        .listStyle(.insetGrouped)
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
