//
//  File.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 26/07/26.
//

import ComposableArchitecture

extension DependencyValues {

    public var appLockManager: AppLockManager {
        get {
            self[AppLockManagerKey.self]
        }
        set {
            self[AppLockManagerKey.self] = newValue
        }
    }
}

private enum AppLockManagerKey: DependencyKey {

    static let liveValue: AppLockManager = {
        fatalError(
            "AppLockManager must be injected by RootDIContainer"
        )
    }()
}
