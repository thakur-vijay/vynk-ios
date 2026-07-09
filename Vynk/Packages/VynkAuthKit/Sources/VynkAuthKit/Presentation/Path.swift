//
//  Path.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import ComposableArchitecture

@Reducer
struct Path {

    @ObservableState
    enum State: Equatable {
        case phoneNumber(PhoneNumberFeature.State)
    }

    enum Action {
        case phoneNumber(PhoneNumberFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.phoneNumber, action: \.phoneNumber) {
            PhoneNumberFeature()
        }
    }
}
