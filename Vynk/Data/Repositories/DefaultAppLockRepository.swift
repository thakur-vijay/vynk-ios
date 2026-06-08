//
//  DefaultAppLockRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//


final class DefaultAppLockRepository: AppLockRepository {

    private let authService: LocalAuthenticationService
    private let store: AppPreferences

    init(
        authService: LocalAuthenticationService,
        store: AppPreferences
    ) {
        self.authService = authService
        self.store = store
    }

    func authenticate() async throws -> Bool {
        try await authService.authenticate()
    }

    func isAppLockEnabled() -> Bool {
        store.isAppLockEnabled
    }

    func setAppLockEnabled(_ enabled: Bool) {
        store.isAppLockEnabled = enabled
    }
}
