//
//  SettingsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation
import SwiftUI

final class SettingsDIContainer {
    
    func makeSettingsView()->SettingsView {
        let viewModel = SettingsViewModel()
        let router = SettingsRouter()
        return SettingsView(
            viewModel: viewModel,
            router: router,
            diContainer: self
        )
    }
    
    func makePrivacyView()->PrivacyView {
        let viewModel = PrivacyViewModel()
        return PrivacyView(viewModel: viewModel)
    }
    
    @ViewBuilder
    func makeDestination(for route: SettingsRoute)-> some View {
        switch route {
        case .profile:
            Text("Profile View")
        case .row(let rowId):
            switch rowId {
            case .privacy: makePrivacyView()
            default: Text("Test")
            }
        }
    }
}
