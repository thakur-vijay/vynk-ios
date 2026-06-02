//
//  FetchDeviceContactsUseCaseTests.swift
//  VynkTests
//
//  Created by Vijay Thakur on 02/06/26.
//

import Testing
@testable import Vynk

struct FetchDeviceContactsUseCaseTests {

    @Test func test_execute_removesDuplicatesAndSortsContacts() async throws {
        let repository = ContactsRepositoryMock()

        repository.contacts = [

            .init(

                id: "1",

                givenName: "Rohit",

                familyName: "",

                fullName: "Rohit",

                phoneNumbers: ["+91 98765 43210"],

                thumbnailImageData: nil

            ),

            .init(

                id: "2",

                givenName: "Aman",

                familyName: "",

                fullName: "Aman",

                phoneNumbers: ["9876543210"],

                thumbnailImageData: nil

            ),

            .init(

                id: "3",

                givenName: "Zara",

                familyName: "",

                fullName: "Zara",

                phoneNumbers: ["9999999999"],

                thumbnailImageData: nil

            )

        ]

        let useCase = FetchDeviceContactsUseCase(
            repository: repository
        )

        let result = try await useCase.execute()
        #expect(result.count == 2)
    }
    
    @Test func test_execute_removesContactsWithoutPhoneNumbers() async throws {
        let repository = ContactsRepositoryMock()

        repository.contacts = [
            .init(
                id: "1",
                givenName: "No Phone",
                familyName: "",
                fullName: "No Phone",
                phoneNumbers: [],
                thumbnailImageData: nil
            ),
            .init(
                id: "2",
                givenName: "Aman",
                familyName: "",
                fullName: "Aman",
                phoneNumbers: ["9876543210"],
                thumbnailImageData: nil
            )
        ]

        let useCase = FetchDeviceContactsUseCase(repository: repository)

        let result = try await useCase.execute()
        #expect(result.count == 1)
        #expect(result.first?.fullName == "Aman")
    }
}
