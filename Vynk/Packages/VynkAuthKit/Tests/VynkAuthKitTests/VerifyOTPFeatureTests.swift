//
//  VerifyOTPFeatureTests.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//


import ComposableArchitecture
import Testing
@testable import VynkAuthKit
@testable import VynkCountryPicker

@MainActor
struct VerifyOTPFeatureTests {

    @Test
    func otpBinding_updatesOTP() async {
        let store = TestStore(
            initialState: VerifyOTPFeature.State(
                phoneNumber: "9876543210"
            )
        ) {
            VerifyOTPFeature()
        }

        await store.send(.binding(.set(\.otp, "123456"))) {
            $0.otp = "123456"
        }
    }

    @Test
    func didNotReceiveCodeTapped_doesNotMutateState() async {
        let store = TestStore(
            initialState: VerifyOTPFeature.State(
                phoneNumber: "9876543210"
            )
        ) {
            VerifyOTPFeature()
        }

        await store.send(.didNotReceiveCodeTapped)
    }

    @Test
    func stateInitialization_setsCountryPhoneNumberAndEmptyOTP() {
        let country = CountryModel(
            id: 1,
            name: "India",
            iso2: "",
            phonecode: "91",
            emoji: ""
        )

        let state = VerifyOTPFeature.State(
            country: country,
            phoneNumber: "9876543210"
        )

        #expect(state.country == country)
        #expect(state.phoneNumber == "9876543210")
        #expect(state.otp.isEmpty)
    }

    @Test
    func stateInitialization_withoutCountry_setsCountryNil() {
        let state = VerifyOTPFeature.State(
            phoneNumber: "9876543210"
        )

        #expect(state.country == nil)
        #expect(state.phoneNumber == "9876543210")
        #expect(state.otp.isEmpty)
    }
}
