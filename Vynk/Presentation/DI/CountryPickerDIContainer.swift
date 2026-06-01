//
//  CountryPickerDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

final class CountryPickerDIContainer {

    func makeViewModel(selectedCountry: CountryModel?) -> CountryPickerViewModel {
        let dataSource = LocalCountryDataSource()
        let repository = DefaultCountryRepository(dataSource: dataSource)
        let useCase = FetchCountriesUseCase(repository: repository)

        return CountryPickerViewModel(
            fetchCountriesUseCase: useCase,
            selectedCountry: selectedCountry
        )
    }

    func makeCountryPickerView(selectedCountry: CountryModel?, onClose: @escaping (CountryModel?)->()) -> CountryPickerView {
        CountryPickerView(
            viewModel: makeViewModel(selectedCountry: selectedCountry),
            onClose: onClose
        )
    }
}
