//
//  SwiftUIView.swift
//  VynkCountryPicker
//
//  Created by Vijay Thakur on 10/07/26.
//

import Foundation
import ComposableArchitecture

public final class CountryPickerDIContainer {

    public init() {}

    public lazy var client: CountryPickerClient = {
        let dataSource = LocalCountryDataSource()
        let repository = DefaultCountryRepository(dataSource: dataSource)
        let fetchCountriesUseCase = FetchCountriesUseCase(repository: repository)
        let fetchCurrentCountryUseCase = FetchCurrentCountryUseCase(repository: repository)
        return CountryPickerClient(
            fetchCurrentCountry: fetchCurrentCountryUseCase.execute,
            fetchCountries: fetchCountriesUseCase.execute
        )
    }()
}


