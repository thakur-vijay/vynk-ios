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
import VynkMainKit
import VynkFoundation
import VynkChatsKit

@available(iOS 17.0, *)
public final class RootDIContainer {
    private let countryDIContainer: CountryPickerDIContainer
    private let chatsDIContainer: ChatsDIContainer
    public init(countryDIContainer: CountryPickerDIContainer, chatsDIContainer: ChatsDIContainer) {
        self.countryDIContainer = countryDIContainer
        self.chatsDIContainer = chatsDIContainer
        Log.debug("Called")
    }

    @MainActor private lazy var store: StoreOf<RootFeature> = Store(
        initialState: RootFeature.State.main(MainFeature.State())
    ) {
        RootFeature()
    } withDependencies: {
        $0.countryPickerClient = self.countryDIContainer.client
        $0.chatsClient = self.chatsDIContainer.client
    }

    @MainActor public func makeView() -> some View {
        RootView(store: store)
    }
}
