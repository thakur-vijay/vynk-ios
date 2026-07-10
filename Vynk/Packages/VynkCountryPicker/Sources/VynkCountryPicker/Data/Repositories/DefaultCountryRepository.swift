//
//  DefaultCountryRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

final class DefaultCountryRepository: CountryRepository, Sendable{

    private let dataSource: LocalCountryDataSource

    init(dataSource: LocalCountryDataSource) {

        self.dataSource = dataSource

    }

    func fetchCountries() throws -> [CountryModel] {

        try dataSource.fetchCountries()

    }

}
