//
//  WelcomeFeatureTests.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//


import ComposableArchitecture
import Testing
@testable import VynkAuthKit

@MainActor
struct WelcomeFeatureTests {

    @Test
    func continueButtonTapped_pushesPhoneNumberScreen() async {
        let store = TestStore(
            initialState: WelcomeFeature.State()
        ) {
            WelcomeFeature()
        }

        await store.send(.continueButtonTapped) {
            $0.path.append(
                .phoneNumber(PhoneNumberFeature.State())
            )
        }
    }

    @Test
    func privacyPolicyLinkTapped_doesNotMutateState() async {
        let store = TestStore(
            initialState: WelcomeFeature.State()
        ) {
            WelcomeFeature()
        }

        await store.send(.linkTapped("/privacyPolicy"))
    }

    @Test
    func termsOfServiceLinkTapped_doesNotMutateState() async {
        let store = TestStore(
            initialState: WelcomeFeature.State()
        ) {
            WelcomeFeature()
        }

        await store.send(.linkTapped("/termsOfService"))
    }
}