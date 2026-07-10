//
//  PhoneNumberFeatureTests.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//


import ComposableArchitecture
import Testing
@testable import VynkAuthKit
import VynkCountryPicker

@MainActor
struct PhoneNumberFeatureTests {

    @Test
    func onTask_loadsCurrentCountry() async throws {
        let country = CountryModel(
            id: 1,
            name: "India",
            iso2: "IN",
            phonecode: "91",
            emoji: "🇮🇳"
        )

        let store = TestStore(
            initialState: PhoneNumberFeature.State()
        ) {
            PhoneNumberFeature()
        } withDependencies: {
            $0.countryPickerClient.fetchCurrentCountry = {
                country
            }
        }

        await store.send(.onTask)
        await store.receive(
            { action in
                switch action {
                case let .currentCountryLoaded(receivedCountry):
                    return receivedCountry == country
                default:
                    return false
                }
            }
        ) {
            $0.selectedCountry = country
        }
    }

    @Test
    func currentCountryLoaded_updatesSelectedCountry() async {
        let country = CountryModel(
            id: 1,
            name: "India",
            iso2: "IN",
            phonecode: "91",
            emoji: "🇮🇳"
        )

        let store = TestStore(
            initialState: PhoneNumberFeature.State()
        ) {
            PhoneNumberFeature()
        }

        await store.send(.currentCountryLoaded(country)) {
            $0.selectedCountry = country
        }
    }

    @Test
    func countryPickerTapped_presentsCountryPicker() async {
        let country = CountryModel(
            id: 1,
            name: "India",
            iso2: "IN",
            phonecode: "91",
            emoji: "🇮🇳"
        )

        let store = TestStore(
            initialState: PhoneNumberFeature.State(
                selectedCountry: country
            )
        ) {
            PhoneNumberFeature()
        }

        await store.send(.countryPickerTapped) {
            $0.destination = .countryPicker(
                CountryPickerFeature.State(
                    selectedCountry: country
                )
            )
        }
    }

    @Test
    func selectingCountry_updatesCountryAndDismissesPicker() async {
        let oldCountry = CountryModel(
            id: 1,
            name: "India",
            iso2: "IN",
            phonecode: "91",
            emoji: "🇮🇳"
        )

        let newCountry = CountryModel(
            id: 2,
            name: "United States",
            iso2: "US",
            phonecode: "1",
            emoji: "🇺🇸"
        )
        
        var initialState = PhoneNumberFeature.State(
            selectedCountry: oldCountry
        )

        initialState.destination = .countryPicker(
            CountryPickerFeature.State(
                selectedCountry: oldCountry
            )
        )

        let store = TestStore(
            initialState: initialState) {
            PhoneNumberFeature()
        }

        store.exhaustivity = .off

        await store.send(
            .destination(
                .presented(
                    .countryPicker(
                        .delegate(
                            .didSelectCountry(newCountry)
                        )
                    )
                )
            )
        ) {
            $0.selectedCountry = newCountry
            $0.destination = nil
        }
    }

    @Test
    func closingCountryPicker_dismissesPicker() async {
        let store = TestStore(
            initialState: PhoneNumberFeature.State()
        ) {
            PhoneNumberFeature()
        }

        await store.send(.countryPickerTapped) {
            $0.destination = .countryPicker(
                CountryPickerFeature.State(
                    selectedCountry: nil
                )
            )
        }

        await store.send(
            .destination(
                .presented(
                    .countryPicker(
                        .delegate(.didClose(nil))
                    )
                )
            )
        ) {
            $0.destination = nil
        }
    }

    @Test
    func bindingPhoneNumber_removesNonNumericCharacters() async {
        let store = TestStore(
            initialState: PhoneNumberFeature.State()
        ) {
            PhoneNumberFeature()
        }

        await store.send(
            .binding(
                .set(
                    \.phoneNumber,
                    "98a76-54b321"
                )
            )
        ) {
            $0.phoneNumber = "987654321"
        }
    }

    @Test
    func nextButtonTapped_withoutCountry_doesNothing() async {
        let store = TestStore(
            initialState: PhoneNumberFeature.State()
        ) {
            PhoneNumberFeature()
        }

        await store.send(.nextButtonTapped)
    }

    @Test
    func nextButtonTapped_sendsDelegate() async {
        let country = CountryModel(
            id: 1,
            name: "India",
            iso2: "IN",
            phonecode: "91",
            emoji: "🇮🇳"
        )

        let store = TestStore(
            initialState: PhoneNumberFeature.State(
                selectedCountry: country
            )
        ) {
            PhoneNumberFeature()
        }

        store.exhaustivity = .off

        await store.send(.binding(.set(\.phoneNumber, "9876543210"))) {
            $0.phoneNumber = "9876543210"
        }

        await store.send(.nextButtonTapped)

        await store.receive(
            { action in
                switch action {
                case let .delegate(.continueWithPhone(receivedCountry, receivedPhoneNumber)):
                    return receivedCountry == country &&
                           receivedPhoneNumber == "9876543210"

                default:
                    return false
                }
            }
        )
    }
    
    @Test
    func isActionEnabled_returnsFalseForEmptyPhoneNumber() {
        let state = PhoneNumberFeature.State()

        #expect(state.isActionEnabled == false)
    }

    @Test
    func isActionEnabled_returnsTrueForValidPhoneNumber() {
        var state = PhoneNumberFeature.State()
        state.phoneNumber = "9876543210"

        #expect(state.isActionEnabled)
    }
}
