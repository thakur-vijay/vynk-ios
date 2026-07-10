//
//  LoadCountriesUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

final class FetchCountriesUseCase: Sendable{

    private let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
    }

    func execute() throws -> [CountryModel] {
        try repository.fetchCountries()
            .sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
    }
}
