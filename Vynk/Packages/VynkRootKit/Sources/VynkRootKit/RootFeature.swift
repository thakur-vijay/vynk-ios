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
    public struct State: Equatable {
        public var auth: AuthFeature.State?
        public var main: MainFeature.State?

        public init() {
            auth = AuthFeature.State()
            main = nil
        }
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
                state.auth = nil
                state.main = MainFeature.State()
                return .none

            case .main(.delegate(.logoutSucceeded)):
                state.main = nil
                state.auth = AuthFeature.State()
                return .none

            case .auth:
                return .none

            case .main:
                return .none
            }
        }
        .ifLet(\.auth, action: \.auth){
            AuthFeature()
        }
        .ifLet(\.main, action: \.main){
            MainFeature()
        }
    }
}
