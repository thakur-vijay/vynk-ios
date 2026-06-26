//
//  CountryPickerViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

@MainActor
@Observable
final class CountryPickerViewModel {

    var countries: [CountryModel] = []
    var selectedCountry: CountryModel?
    var searchText = ""

    private let fetchCountriesUseCase: FetchCountriesUseCase

    init(fetchCountriesUseCase: FetchCountriesUseCase, selectedCountry: CountryModel?) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
        self.selectedCountry = selectedCountry
    }

    var filteredCountries: [CountryModel] {
        guard searchText.isNotEmptyString else { return countries }

        return countries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
            || $0.dialCode.contains(searchText)
            || $0.iso2.localizedCaseInsensitiveContains(searchText)
        }
    }

    func loadCountries() {
        do {
            countries = try fetchCountriesUseCase.execute()
        } catch {
            AppLogger.error(error.localizedDescription, tag: "CountryPickerViewModel")
        }
    }
    
    var currentCountry: CountryModel? {
        selectedCountry ?? countries.first {
            $0.iso2 == Locale.current.region?.identifier
        }
    }
}
