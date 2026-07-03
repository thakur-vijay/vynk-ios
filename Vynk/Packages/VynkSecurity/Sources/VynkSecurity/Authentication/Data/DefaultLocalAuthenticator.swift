//
//  LocalAuthenticationService.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 03/07/26.
//


import LocalAuthentication

public final class DefaultLocalAuthenticator: LocalAuthenticating {
    
    public init(){
        
    }

    public func authenticate(reason: String) async throws -> Bool {
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
