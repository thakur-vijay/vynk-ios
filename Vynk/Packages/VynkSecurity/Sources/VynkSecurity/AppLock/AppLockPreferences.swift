//
//  AppLockPreferences.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 03/07/26.
//

import Foundation

@MainActor
public protocol AppLockPreferences: AnyObject, Sendable {
    var isAppLockEnabled: Bool { get set }
    var appLockOption: String { get set }
}
