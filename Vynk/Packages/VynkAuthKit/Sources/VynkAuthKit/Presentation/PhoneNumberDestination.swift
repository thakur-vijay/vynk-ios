//
//  Destination.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//


import Foundation
import ComposableArchitecture
import VynkCountryPicker

@Reducer
internal struct PhoneNumberDestination {

    @ObservableState
    enum State: Equatable {
        case countryPicker(CountryPickerFeature.State)
    }

    enum Action {
        case countryPicker(CountryPickerFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {

        Reduce { state, action in
            .none
        }
        .ifCaseLet(\.countryPicker, action: \.countryPicker) {
            CountryPickerFeature()
        }
    }
}
