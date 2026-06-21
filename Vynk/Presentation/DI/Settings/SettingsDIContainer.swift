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
    private let listsDIContainer: ListsDIContainer
    
    init(
        appLockManager: AppLockManager,
        listsDIContainer: ListsDIContainer
    ) {
        self.appLockManager = appLockManager
        self.listsDIContainer = listsDIContainer
    }
    
    func makeSettingsView()->SettingsView {
        let viewModel = SettingsViewModel()
        let router = SettingsRouter()
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
    
    @ViewBuilder
    func makeDestination(for route: SettingsRoute)-> some View {
        switch route {
        case .profile:
            Text("Profile View")
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
