//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 16/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem


public struct GeneralSectionView: View {
    let store: StoreOf<GeneralSectionFeature>
    
    public init(store: StoreOf<GeneralSectionFeature>) {
        self.store = store
    }
    
    
    public var body: some View {
        SectionView(section: store.section) { rowID, _ in
            store.send(.rowTapped(rowID))
        }
    }
}
