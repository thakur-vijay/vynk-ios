//
//  AppLockAction.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

enum AppLockAction: @MainActor RowIDProtocol {
    case requireFaceID

    var symbol: String? {
         nil
    }
}
