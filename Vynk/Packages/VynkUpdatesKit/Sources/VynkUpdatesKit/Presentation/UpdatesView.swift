//
//  SwiftUIView.swift
//  VynkUpdatesKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture

public struct UpdatesView: View {
    let store: StoreOf<UpdatesFeature>
    
    public init(store: StoreOf<UpdatesFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
