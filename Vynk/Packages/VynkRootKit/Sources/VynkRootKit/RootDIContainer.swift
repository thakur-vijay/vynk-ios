//
//  SwiftUIView.swift
//  VynkRootKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture
import SwiftUI
import VynkCountryPicker
import VynkAuthKit
import VynkFoundation

@available(iOS 17.0, *)
public final class RootDIContainer {
    private let countryDIContainer: CountryPickerDIContainer
    public init(countryDIContainer: CountryPickerDIContainer) {
        self.countryDIContainer = countryDIContainer
        Log.debug("Called")
    }

    @MainActor private lazy var store: StoreOf<RootFeature> = Store(
        initialState: RootFeature.State.auth(AuthFeature.State())
    ) {
        RootFeature()
    } withDependencies: {
        $0.countryPickerClient = self.countryDIContainer.makeClient()
    }

    @MainActor public func makeView() -> some View {
        RootView(store: store)
    }
}
