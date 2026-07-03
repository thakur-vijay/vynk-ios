//
//  DefaultAppLockRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//


import VynkSecurity

final class DefaultAppLockRepository: AppLockRepository {

    private let authService: LocalAuthenticating
    private var store: AppPreferencesManaging

    init(
        authService: LocalAuthenticating,
        store: AppPreferencesManaging
    ) {
        self.authService = authService
        self.store = store
    }

    func authenticate() async throws -> Bool {
        try await authService.authenticate(reason: "Unlock Vynk")
    }

    func isAppLockEnabled() -> Bool {
        store.isAppLockEnabled
    }

    func setAppLockEnabled(_ enabled: Bool) {
        store.isAppLockEnabled = enabled
    }
}
