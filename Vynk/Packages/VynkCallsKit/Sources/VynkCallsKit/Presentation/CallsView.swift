//
//  SwiftUIView.swift
//  VynkCallsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture

public struct CallsView: View {
    let store: StoreOf<CallsFeature>
    
    public init(store: StoreOf<CallsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("CallsView")
    }
}

