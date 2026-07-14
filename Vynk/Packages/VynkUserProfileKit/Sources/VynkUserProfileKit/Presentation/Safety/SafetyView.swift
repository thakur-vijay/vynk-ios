//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem


public struct SafetyView: View {
    let store: StoreOf<SafetyFeature>
    
    public init(store: StoreOf<SafetyFeature>) {
        self.store = store
    }
    
    
    public var body: some View {
        SectionView(section: store.section) { rowID, _ in
            store.send(.rowTapped(rowID))
        }
    }
}
