//
//  CountryPickerService.swift
//  VynkCountryPicker
//
//  Created by Vijay Thakur on 27/06/26.
//

import Foundation

@available(iOS 16, *)
public enum CountryPickerService {

    public static func countries() throws -> [CountryModel] {
        let dataSource = LocalCountryDataSource()
        let repository = DefaultCountryRepository(dataSource: dataSource)
        return try FetchCountriesUseCase(repository: repository).execute()
    }

    public static func currentCountry(
        selectedCountry: CountryModel? = nil
    ) throws -> CountryModel? {
        let countries = try countries()

        return selectedCountry ?? countries.first {
            $0.iso2 == Locale.current.region?.identifier
        }
    }
}
