//
//  AppLockRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

protocol AppLockRepository: Sendable{
    func authenticate() async throws -> Bool
    func isAppLockEnabled()async -> Bool
    func setAppLockEnabled(_ enabled: Bool)async
}
