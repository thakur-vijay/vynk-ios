//
//  SwiftUIView.swift
//  VynkRootKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture
import VynkAuthKit
import VynkMainKit

@Reducer
public struct RootFeature {

    @ObservableState
    public enum State: Equatable {
        case auth(AuthFeature.State)
        case main(MainFeature.State)
    }

    public enum Action {
        case auth(AuthFeature.Action)
        case main(MainFeature.Action)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .auth(.delegate(.loginSucceeded)):
                state = .main(MainFeature.State())
                return .none

            case .main(.delegate(.logoutSucceeded)):
                state = .auth(AuthFeature.State())
                return .none

            case .auth:
                return .none

            case .main:
                return .none
            }
        }
        .ifCaseLet(\.auth, action: \.auth) {
            AuthFeature()
        }
        .ifCaseLet(\.main, action: \.main) {
            MainFeature()
        }
    }
}
