//
//  PrivacyView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

struct PrivacyView: View {
    @State private var viewModel: PrivacyViewModel
    init(viewModel: PrivacyViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
  
    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                SectionView(section: section, toggleBinding: viewModel.binding(for:)) { rowID, kind in
                    if kind == .navigation {
                    }
                }
            }
        }
        .navigationTitle("Privacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

