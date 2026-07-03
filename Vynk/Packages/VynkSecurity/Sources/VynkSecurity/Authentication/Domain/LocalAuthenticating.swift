//
//  LocalAuthenticating 2.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 03/07/26.
//

import Foundation

@MainActor
public protocol LocalAuthenticating {

    func authenticate(
        reason: String
    ) async throws -> Bool
}
