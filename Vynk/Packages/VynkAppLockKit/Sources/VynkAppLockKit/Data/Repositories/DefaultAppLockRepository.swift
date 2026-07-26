//
//  DefaultAppLockRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//


import VynkSecurity

final class DefaultAppLockRepository: AppLockRepository {

    private let authService: LocalAuthenticating
    private let store: AppLockPreferences

    init(
        authService: LocalAuthenticating,
        store: AppLockPreferences
    ) {
        self.authService = authService
        self.store = store
    }

    func authenticate() async throws -> Bool {
        try await authService.authenticate(reason: "Unlock Vynk")
    }

    func isAppLockEnabled()async -> Bool {
       await store.isAppLockEnabled
    }

    func setAppLockEnabled(_ enabled: Bool)async {
        await MainActor.run {
            store.isAppLockEnabled = enabled
        }
    }
}
