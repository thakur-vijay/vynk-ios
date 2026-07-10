//
//  SwiftUIView.swift
//  VynkCountryPicker
//
//  Created by Vijay Thakur on 10/07/26.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct CountryPickerFeature {

    @Dependency(\.countryPickerClient)
    private var client

    @ObservableState
    public struct State: Equatable {

        public var countries: [CountryModel] = []

        public var selectedCountry: CountryModel?

        public var searchText = ""

        public init(selectedCountry: CountryModel?) {
            self.selectedCountry = selectedCountry
        }
    }

    public enum Action: BindableAction {

        case binding(BindingAction<State>)

        case onTask

        case countriesLoaded([CountryModel])

        case countryTapped(CountryModel)

        case closeButtonTapped

        case delegate(Delegate)

        public enum Delegate {
            case didSelectCountry(CountryModel)
            case didClose(CountryModel?)
        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {

        BindingReducer()

        Reduce { state, action in
            let client = client

            switch action {

            case .onTask:

                return .run { send in
                    let countries = try client.fetchCountries()
                    await send(.countriesLoaded(countries))
                }

            case let .countriesLoaded(countries):

                state.countries = countries
                return .none

            case let .countryTapped(country):

                state.selectedCountry = country

                return .send(
                    .delegate(.didSelectCountry(country))
                )

            case .closeButtonTapped:

                return .send(
                    .delegate(.didClose(state.selectedCountry))
                )

            case .binding:
                return .none

            case .delegate:
                return .none
            }
        }
    }
}

internal extension CountryPickerFeature.State {

    var filteredCountries: [CountryModel] {

        guard !searchText
            .replacingOccurrences(of: " ", with: "")
            .isEmpty
        else {
            return countries
        }

        return countries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
            || $0.dialCode.contains(searchText)
            || $0.iso2.localizedCaseInsensitiveContains(searchText)
        }
    }

    var currentCountry: CountryModel? {

        selectedCountry
        ?? countries.first {
            $0.iso2 == Locale.current.region?.identifier
        }
    }
}
