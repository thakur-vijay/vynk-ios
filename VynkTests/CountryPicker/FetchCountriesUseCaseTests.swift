//
//  FetchCountriesUseCaseTests.swift
//  VynkTests
//
//  Created by Vijay Thakur on 02/06/26.
//

import Testing
@testable import Vynk

struct FetchCountriesUseCaseTests {

    @Test func test_execute_returnsCountriesSortedByName() throws {
        
        let repository = CountryRepositoryMock()

        repository.countries = [

            .init(id: 1, name: "India", iso2: "IN", phonecode: "91", emoji: "🇮🇳"),

            .init(id: 2, name: "Afghanistan", iso2: "AF", phonecode: "93", emoji: "🇦🇫"),

            .init(id: 3, name: "Germany", iso2: "DE", phonecode: "49", emoji: "🇩🇪")

        ]

        let useCase = FetchCountriesUseCase(repository: repository)

        let result = try useCase.execute()
        #expect(result.map(\.name) == ["Afghanistan", "Germany", "India"])
    }

}
