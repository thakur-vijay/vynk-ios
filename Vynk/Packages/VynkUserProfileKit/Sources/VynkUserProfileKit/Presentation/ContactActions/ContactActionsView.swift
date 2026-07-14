//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem


public struct ContactActionsView: View {
    let store: StoreOf<ContactActionsFeature>
    
    public init(store: StoreOf<ContactActionsFeature>) {
        self.store = store
    }
    
    
    public var body: some View {
        SectionView(section: store.section) { rowID, _ in
            store.send(.rowTapped(rowID))
        }
    }
}
