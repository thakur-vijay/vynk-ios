//
//  LoadCountryDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

final class LocalCountryDataSource {

    func fetchCountries() throws -> [CountryModel] {
        guard let url = Bundle.main.url(
            forResource: "countries",
            withExtension: "json"
        ) else {
            throw CountryPickerError.fileNotFound
        }

        let data = try Data(contentsOf: url)

        return try JSONDecoder().decode(
            [CountryModel].self,
            from: data
        )
    }
}

private enum CountryPickerError: Error {
    case fileNotFound
}
