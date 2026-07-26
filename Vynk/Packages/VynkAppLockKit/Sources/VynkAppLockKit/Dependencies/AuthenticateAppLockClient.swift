//
//  AuthenticateAppLockClient.swift
//  VynkAppLockKit
//
//  Created by Vijay Thakur on 26/07/26.
//


import ComposableArchitecture

public struct AuthenticateAppLockClient: Sendable {
    public var authenticate: @Sendable ()async throws -> Bool

    public init(
        authenticate: @escaping @Sendable ()async throws -> Bool
    ) {
        self.authenticate = authenticate
    }
}

extension AuthenticateAppLockClient {

    static func live(
        authenticateAppLockUseCase: AuthenticateAppLockUseCase,
    ) -> Self {

        Self(
            authenticate: {
                try await authenticateAppLockUseCase.execute()
            }
        )
    }
}

extension AuthenticateAppLockClient: DependencyKey {

    public static let liveValue = Self(
        authenticate: {
            fatalError("session not implemented")
        },
    )
}

extension AuthenticateAppLockClient: TestDependencyKey {

    public static let testValue = Self(
        authenticate: {
            true
        }
    )
}

public extension DependencyValues {

    var autheticationAppLock: AuthenticateAppLockClient {
        get { self[AuthenticateAppLockClient.self] }
        set { self[AuthenticateAppLockClient.self] = newValue }
    }
}
