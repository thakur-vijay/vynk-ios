//
//  AppPreferences.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import Foundation

final class AppPreferences: AppPreferencesManaging{
    
    @UserDefault(key: AppPreferenceKeys.isContactsPermissionStatusCardHidden, defaultValue: false)
    var isContactsPermissionStatusCardHidden: Bool
    
    @UserDefault(
        key: AppPreferenceKeys.isAppLockEnabled,
        defaultValue: false
    )
    var isAppLockEnabled: Bool
    
    @UserDefault(
        key: AppPreferenceKeys.appLockOption,
        defaultValue: AppLockOption.immediately.rawValue
    )
    var appLockOption: String
}
