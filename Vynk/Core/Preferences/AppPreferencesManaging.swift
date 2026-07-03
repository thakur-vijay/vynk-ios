//
//  AppPreferencesManaging.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/07/26.
//

import Foundation
import VynkSecurity

@MainActor
protocol AppPreferencesManaging: AppLockPreferences{

    var isContactsPermissionStatusCardHidden: Bool { get set }

}
