//
//  File.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkCountryPicker

@available(iOS 17.0, *)
public final class AuthDIContainer {
    private let countryPickerClient: CountryPickerClient

    public init(countryPickerClient: CountryPickerClient) {
        self.countryPickerClient = countryPickerClient
    }

    // Created once, lives as long as the container does
    @MainActor private lazy var store: StoreOf<WelcomeFeature> = Store(
        initialState: WelcomeFeature.State()
    ) {
        WelcomeFeature()
    } withDependencies: {
        $0.countryPickerClient = self.countryPickerClient
    }

    @MainActor public func makeView() -> AnyView {
        AnyView(WelcomeView(store: store))
    }
}
