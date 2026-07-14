//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem


public struct ContactDetailsView: View {
    let store: StoreOf<ContactDetailsFeature>
    
    public init(store: StoreOf<ContactDetailsFeature>) {
        self.store = store
    }
    
    
    public var body: some View {
        SectionView(section: store.section) { rowID, _ in
            store.send(.rowTapped(rowID))
        }
    }
}
