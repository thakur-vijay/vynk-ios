//
//  PrivaceRowID.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation

enum PrivaceRowID: @MainActor RowIDProtocol {
    case lastSeenAndOnline
    case profilePicture
    case about
    case links
    case groups
    case avatarStickers
    case status
    
    case liveLocation
    
    case calls
    
    case contacts
    
    case defaultMessageTimer
    
    case readReceipts
    
    case appLock
    
    case chatLock
    
    case allowCameraEffects
    
    case advanced
    
    case privacyCheckup
    
    var symbol: String? {
        nil
    }

}
