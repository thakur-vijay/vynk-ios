//
//  AppLockDIContainer.swift
//  VynkAppLockKit
//
//  Created by Vijay Thakur on 26/07/26.
//

import VynkSecurity
import ComposableArchitecture

public final class AppLockDIContainer {

    private let preferences: AppLockPreferences

    public init(preferences: AppLockPreferences) {
        self.preferences = preferences
    }
        
    public func register(_ values: inout DependencyValues) {
        values.autheticationAppLock = client
    }
    
    private lazy var client: AuthenticateAppLockClient = {
        let service = DefaultLocalAuthenticator()
        let repository = DefaultAppLockRepository(authService: service, store: preferences)
        let authenticateUseCase = AuthenticateAppLockUseCase(repository: repository)
        
        return AuthenticateAppLockClient(authenticate: authenticateUseCase.execute)
    }()
}
