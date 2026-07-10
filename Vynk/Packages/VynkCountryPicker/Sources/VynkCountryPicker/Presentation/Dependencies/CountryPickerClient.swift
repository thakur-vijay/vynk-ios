//
//  CountryPickerClient.swift
//  VynkCountryPicker
//
//  Created by Vijay Thakur on 10/07/26.
//


import ComposableArchitecture

public struct CountryPickerClient : Sendable{

    public var fetchCurrentCountry: @Sendable () throws -> CountryModel?
    public var fetchCountries: @Sendable () throws -> [CountryModel]
}

extension CountryPickerClient {

    static func live(
        fetchCurrentCountryUseCase: FetchCurrentCountryUseCase,
        fetchCountriesUseCase: FetchCountriesUseCase,
    ) -> Self {

        Self(
            fetchCurrentCountry: {
                try fetchCurrentCountryUseCase.execute()
            },
            fetchCountries: {
                try fetchCountriesUseCase.execute()
            }
        )
    }
}

extension CountryPickerClient: DependencyKey {

    public static let liveValue = Self(
        fetchCurrentCountry: {
            fatalError("Unimplemented")
        },
        fetchCountries: {
            fatalError("Unimplemented")
        }
    )
}

extension CountryPickerClient: TestDependencyKey {

    public static let testValue = Self(
        fetchCurrentCountry: {
            nil
        },
        fetchCountries: {
            []
        }
    )
}

public extension DependencyValues {

    var countryPickerClient: CountryPickerClient {
        get { self[CountryPickerClient.self] }
        set { self[CountryPickerClient.self] = newValue }
    }
}
