//
//  File.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import ComposableArchitecture

@Reducer
public struct WelcomeFeature {

    @ObservableState
    public struct State: Equatable {

        public init() {}
    }

    public enum Action {
        case continueButtonTapped
        case linkTapped(String)
    }

    public init() {}

    public var body: some ReducerOf<Self> {

        Reduce { state, action in

            switch action {

            case .continueButtonTapped:
                return .none

            case .linkTapped:
                return .none
            }
        }
    }
}
