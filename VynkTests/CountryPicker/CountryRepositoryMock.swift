//
//  CountryRepositoryMock.swift
//  VynkTests
//
//  Created by Vijay Thakur on 02/06/26.
//

import Testing
@testable import Vynk

final class CountryRepositoryMock: CountryRepository {

    var countries: [CountryModel] = []
    var error: Error?

    func fetchCountries() throws -> [CountryModel] {
        if let error { throw error }
        return countries
    }
}
