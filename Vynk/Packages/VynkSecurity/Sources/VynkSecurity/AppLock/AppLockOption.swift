//
//  AppLockOption.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 03/07/26.
//

import Foundation

public enum AppLockOption: String, CaseIterable, Sendable {
    case immediately
    case afterOneMinute
    case afterFifteenMinutes
    case afterOneHour
}
