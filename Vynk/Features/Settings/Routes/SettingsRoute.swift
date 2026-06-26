//
//  SettingsRoute.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation

enum SettingsRoute: Hashable {
    case profile
    case profileQRCode
    case row(SettingsRowID)
    case privacy(PrivaceRowID)
}
