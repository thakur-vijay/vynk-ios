//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem


public struct SharedMediaView: View {
    let store: StoreOf<SharedMediaFeature>
    
    public init(store: StoreOf<SharedMediaFeature>) {
        self.store = store
    }
    
    
    public var body: some View {
        SectionView(section: store.section) { rowID, _ in
            store.send(.rowTapped(rowID))
        }
    }
}
