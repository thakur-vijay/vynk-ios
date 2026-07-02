//
//  AppLockDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

final class AppLockDIContainer {

    private let appPreferences: AppPreferencesManaging

    init(appPreferences: AppPreferencesManaging) {
        self.appPreferences = appPreferences
    }
    
    func makeView()-> AppLockView {
        let service = LocalAuthenticationService()
        let repository = DefaultAppLockRepository(authService: service, store: appPreferences)
        let authenticateUseCase = AuthenticateAppLockUseCase(repository: repository)
        let viewModel = AppLockViewModel(authenticateUseCase: authenticateUseCase)
        return AppLockView(viewModel: viewModel)
    }
}
