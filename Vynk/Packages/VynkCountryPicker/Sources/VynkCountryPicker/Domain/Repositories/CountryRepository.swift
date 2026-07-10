//
//  CountryRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

protocol CountryRepository: Sendable{
    func fetchCountries() throws -> [CountryModel]
}
