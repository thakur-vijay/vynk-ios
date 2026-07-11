//
//  SwiftUIView.swift
//  VynkCommunitiesKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture

public struct CommunitiesView: View {
    let store: StoreOf<CommunitiesFeature>
    
    public init(store: StoreOf<CommunitiesFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
