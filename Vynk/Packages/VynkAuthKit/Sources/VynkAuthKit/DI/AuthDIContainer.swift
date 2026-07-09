//
//  File.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import SwiftUI
import ComposableArchitecture

@available(iOS 17.0, *)
public final class AuthDIContainer{
    public init() {
    }
    
    @MainActor public func makeView() -> AnyView {
        let store = Store(initialState: WelcomeFeature.State()) {
            WelcomeFeature()
        }
        return AnyView(
            WelcomeView(
                store: store,
            )
        )
    }
}
