//
//  AppPreferences.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import Foundation

final class AppPreferences {
    
    @UserDefault(key: AppPreferenceKeys.isContactsPermissionStatusCardHidden, defaultValue: false)
    var isContactsPermissionStatusCardHidden: Bool
}
