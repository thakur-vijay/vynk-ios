//
//  LocalAuthenticationService.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import LocalAuthentication

final class LocalAuthenticationService {

    func authenticate(reason: String = "Unlock Vynk") async throws -> Bool {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"

        let policy: LAPolicy = .deviceOwnerAuthentication

        var error: NSError?

        guard context.canEvaluatePolicy(policy, error: &error) else {
            throw error ?? LAError(.biometryNotAvailable)
        }

        return try await context.evaluatePolicy(
            policy,
            localizedReason: reason
        )
    }
}
