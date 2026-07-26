//
//  File.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 26/07/26.
//

import Foundation
import VynkFoundation

public final class UserDefaultsAppLockPreferences: AppLockPreferences{
    
    public init() {
    }

    @UserDefault(
        key: AppLockPreferenceKeys.isAppLockEnabled,
        defaultValue: true
    )
    public var isAppLockEnabled: Bool
    
    @UserDefault(
        key: AppLockPreferenceKeys.appLockOption,
        defaultValue: AppLockOption.immediately.rawValue
    )
    public var appLockOption: String
}
