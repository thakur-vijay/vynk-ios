//
//  PrivacyAppLockView.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import SwiftUI

struct PrivacyAppLockView: View {
    @State private var viewModel: PrivacyAppLockViewModel
    
    init(viewModel: PrivacyAppLockViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
        
            SectionView(section: viewModel.action) { _ in
                return .init {
                    viewModel.isFaceIDRequired
                } set: { newValue in
                    viewModel.setFaceIDRequired(newValue)
                }

            } onRowTap: { rowID, kind in
                
            }

            if viewModel.isFaceIDRequired {
                SectionView(
                    section: viewModel.appLockOptions,
                    selection: viewModel.selectedOption
                ) { rowID, kind in
                    viewModel.selectOption(rowID)
                }
            }
        }
        .navigationTitle("App lock")
    }
}
