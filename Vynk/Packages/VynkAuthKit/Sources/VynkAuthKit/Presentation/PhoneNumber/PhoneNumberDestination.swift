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
public struct PhoneNumberDestination {

    @ObservableState
    public enum State: Equatable {
        case countryPicker(CountryPickerFeature.State)
    }

    public enum Action {
        case countryPicker(CountryPickerFeature.Action)
    }

    init() {}

    public var body: some ReducerOf<Self> {

        Reduce { state, action in
            .none
        }
        .ifCaseLet(\.countryPicker, action: \.countryPicker) {
            CountryPickerFeature()
        }
    }
}
