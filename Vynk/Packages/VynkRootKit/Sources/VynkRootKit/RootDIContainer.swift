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
import VynkChatLists
import VynkQRCodeKit
import VynkScannerKit

@available(iOS 17.0, *)
public final class RootDIContainer {
    private let countryDIContainer: CountryPickerDIContainer
    private let chatsDIContainer: ChatsDIContainer
    private let listsDIContainer: ListsDIContainer
    private let screenBrighness: ScreenBrightnessManaging
    private let scannerDIContainer: ScannerDIContainer
    public init(
        countryDIContainer: CountryPickerDIContainer,
        chatsDIContainer: ChatsDIContainer,
        listsDIContainer: ListsDIContainer,
        screenBrighness: ScreenBrightnessManaging,
        scannerDIContainer: ScannerDIContainer
    ) {
        self.countryDIContainer = countryDIContainer
        self.chatsDIContainer = chatsDIContainer
        self.listsDIContainer = listsDIContainer
        self.screenBrighness = screenBrighness
        self.scannerDIContainer = scannerDIContainer
        Log.debug("Called")
    }

    @MainActor private lazy var store: StoreOf<RootFeature> = Store(
        initialState: RootFeature.State.main(MainFeature.State())
    ) {
        RootFeature()
    } withDependencies: {
        self.countryDIContainer.register(&$0)
        self.chatsDIContainer.register(&$0)
        self.listsDIContainer.register(&$0)
        self.scannerDIContainer.register(&$0)
        $0.screenBrightness = .init(
            setBrightness: self.screenBrighness.setBrightness(_:),
            restoreBrightness: self.screenBrighness.restoreBrightness
        )
    }

    @MainActor public func makeView() -> some View {
        RootView(store: store)
    }
}
