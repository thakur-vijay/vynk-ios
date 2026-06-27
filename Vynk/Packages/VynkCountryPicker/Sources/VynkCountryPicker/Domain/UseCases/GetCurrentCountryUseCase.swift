//
//  GetCurrentCountryUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation

@available(iOS 16, *)
final class GetCurrentCountryUseCase {

    private let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
    }

    func execute() throws -> CountryModel? {
        let countries = try repository.fetchCountries()

        return countries.first {
            $0.iso2 == Locale.current.region?.identifier
        }
    }
}
