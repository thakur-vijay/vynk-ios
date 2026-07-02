//
//  AppPreferencesManaging.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/07/26.
//

import Foundation

@MainActor
protocol AppPreferencesManaging {

    var isContactsPermissionStatusCardHidden: Bool { get set }
    
    var isAppLockEnabled: Bool { get set }

    var appLockOption: String { get set }

}
