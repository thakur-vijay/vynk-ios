//
//  AppLockViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

@MainActor
@Observable
final class AppLockViewModel {

    private(set) var isUnlocked = false
    var showError = false

    private let authenticateUseCase: AuthenticateAppLockUseCase

    init(
        authenticateUseCase: AuthenticateAppLockUseCase,
    ) {
        self.authenticateUseCase = authenticateUseCase
    }

    func unlock()async-> Bool{
        do {
            return try await authenticateUseCase.execute()
        } catch {
            return false
        }
    }
}
