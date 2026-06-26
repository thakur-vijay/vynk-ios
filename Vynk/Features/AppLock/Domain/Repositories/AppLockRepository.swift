//
//  AppLockRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

protocol AppLockRepository {
    func authenticate() async throws -> Bool
    func isAppLockEnabled() -> Bool
    func setAppLockEnabled(_ enabled: Bool)
}
