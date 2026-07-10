//
//  Destination.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//


import Foundation
import ComposableArchitecture

@Reducer
internal struct Destination {

    @ObservableState
    enum State: Equatable {
        case phoneNumber(PhoneNumberFeature.State)
        case countryPicker(CountryPickerFeature.State)
    }

    enum Action {
        case phoneNumber(PhoneNumberFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {

        Reduce { state, action in
            .none
        }
        .ifCaseLet(\.phoneNumber, action: \.phoneNumber) {
            PhoneNumberFeature()
        }
    }
}
