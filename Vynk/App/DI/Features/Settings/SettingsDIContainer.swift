//
//  SettingsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation
import SwiftUI

final class SettingsDIContainer {
    private let appLockManager: AppLockManager
    private let brightnessManager: ScreenBrightnessManaging
    private let listsDIContainer: ListsDIContainer
    private let scannerDIContainer: ScannerDIContainer
    private let router: SettingsRouter
    private let chatNavigator: ChatNavigator
    
    init(
        appLockManager: AppLockManager,
        brightnessManager: ScreenBrightnessManaging,
        listsDIContainer: ListsDIContainer,
        scannerDIContainer: ScannerDIContainer,
        router: SettingsRouter,
        chatNavigator: ChatNavigator
    ) {
        self.appLockManager = appLockManager
        self.brightnessManager = brightnessManager
        self.listsDIContainer = listsDIContainer
        self.scannerDIContainer = scannerDIContainer
        self.router = router
        self.chatNavigator = chatNavigator
    }
    
    func makeSettingsView()->SettingsView {
        let viewModel = SettingsViewModel()
        return SettingsView(
            viewModel: viewModel,
            router: router,
            diContainer: self
        )
    }
    
    ///inner containers
    private lazy var privacyDIContainer: PrivacyDIContainer = {
        PrivacyDIContainer(
            appLockManager: appLockManager
        )
    }()
    
    private lazy var profileQRCodeDIContainer: ProfileQRCodeDIContainer = {
        ProfileQRCodeDIContainer(
            screenBrightnessManager: brightnessManager,
            chatNavigator: chatNavigator
        ) { result in
            self.scannerDIContainer.makeScannerView(result: result)
        }
    }()
    
    @ViewBuilder
    func makeDestination(for route: SettingsRoute)-> some View {
        switch route {
        case .profile:
            Text("Profile View")
        case .profileQRCode:
            profileQRCodeDIContainer.makeProfileQRCodeView()
        case .row(let rowId):
            switch rowId {
            case .privacy: privacyDIContainer.makePrivacyView()
            case .lists: listsDIContainer.makeListsView()
            default: Text("Test")
            }
        case .privacy(let rowId):
            privacyDIContainer.makeDestination(for: rowId)
        }
    }
}
