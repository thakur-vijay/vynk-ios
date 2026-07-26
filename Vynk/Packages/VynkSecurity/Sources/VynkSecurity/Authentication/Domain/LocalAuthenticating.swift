//
//  LocalAuthenticating 2.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 03/07/26.
//

import Foundation

public protocol LocalAuthenticating: Sendable{

    func authenticate(
        reason: String
    ) async throws -> Bool
}
