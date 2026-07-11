//
//  AuthFeature.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 11/07/26.
//


import ComposableArchitecture

@Reducer
public struct AuthFeature {

    @ObservableState
    public struct State: Equatable {

        public var welcome = WelcomeFeature.State()

        public var path = StackState<Path.State>()

        public init() {}
    }

    public enum Action {
        case welcome(WelcomeFeature.Action)
        case path(StackActionOf<Path>)
        case delegate(Delegate)

        public enum Delegate: Equatable {
            case loginSucceeded
        }
    }

    @Reducer
    public enum Path {
        case phoneNumber(PhoneNumberFeature)
        case verifyOTP(VerifyOTPFeature)
    }

    public init() {}

    public var body: some ReducerOf<Self> {

        Scope(
            state: \.welcome,
            action: \.welcome
        ) {
            WelcomeFeature()
        }

        Reduce { state, action in
            switch action {

            case .welcome(.continueButtonTapped):
                state.path.append(
                    .phoneNumber(
                        PhoneNumberFeature.State()
                    )
                )
                return .none

            case let .path(
                .element(
                    _,
                    action: .phoneNumber(
                        .delegate(
                            .continueWithPhone(country, phone)
                        )
                    )
                )
            ):

                state.path.append(
                    .verifyOTP(
                        VerifyOTPFeature.State(
                            country: country,
                            phoneNumber: phone
                        )
                    )
                )

                return .none

            case .path(
                .element(
                    _,
                    action: .verifyOTP(
                        .delegate(.loginSucceeded)
                    )
                )
            ):

                return .send(
                    .delegate(.loginSucceeded)
                )

            case .welcome:
                return .none

            case .path:
                return .none

            case .delegate:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension AuthFeature.Path.State: Equatable {}
