//
//  SwiftUIView.swift
//  VynkRootKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkAuthKit
import VynkMainKit

struct RootView: View {

    let store: StoreOf<RootFeature>
    var body: some View {
        if let store = store.scope(\.auth, action: \.auth){
            AuthView(store: store)
        }else if let store = store.scope(\.main, action: \.main){
            MainView(store: store)
        }
    }
}
