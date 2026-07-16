//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 17/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem


public struct PreferencesSectionView: View {
    let store: StoreOf<PreferencesSectionFeature>
    
    public init(store: StoreOf<PreferencesSectionFeature>) {
        self.store = store
    }
    
    
    public var body: some View {
        SectionView(section: store.section) { rowID, _ in
            store.send(.rowTapped(rowID))
        }
    }
}
