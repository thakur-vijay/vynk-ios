//
//  File.swift
//  VynkPrivacyKit
//
//  Created by Vijay Thakur on 27/07/26.
//

import SwiftUI
import ComposableArchitecture

public struct PrivacyView: View {
    let store: StoreOf<PrivacyFeature>
    
    public init(store: StoreOf<PrivacyFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List {
//            ForEach(viewModel.sections) { section in
//                SectionView(section: section, toggleBinding: viewModel.binding(for:)) { rowID, kind in
//                    if kind == .navigation {
//                    }
//                }
//            }
        }
        .navigationTitle("Privacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}
