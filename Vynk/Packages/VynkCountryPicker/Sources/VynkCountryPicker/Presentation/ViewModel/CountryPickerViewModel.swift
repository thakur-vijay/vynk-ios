//
//  CountryPickerViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

@available(iOS 17.0, *)
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
        guard !searchText.replacingOccurrences(of: " ", with: "").isEmpty else { return countries }

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
            print(error.localizedDescription)
        }
    }
    
    var currentCountry: CountryModel? {
        selectedCountry ?? countries.first {
            $0.iso2 == Locale.current.region?.identifier
        }
    }
}
