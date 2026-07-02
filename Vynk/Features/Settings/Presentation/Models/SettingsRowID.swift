//
//  SettingsRowID.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import Foundation

enum SettingsRowID: @MainActor RowIDProtocol{
    case lists
    case broadcastMessages
    case starred
    case linkedDevices
    case account
    case privacy
    case chats
    case notifications
    case payments
    case storageAndData
    case helpAndFeedback
    case inviteAFriend
    
    var symbol: String? {
        switch self {
        case .lists:
            AppSymbols.ChatAction.addToListMenu.name
        case .broadcastMessages:
            AppSymbols.broadcast.name
        case .starred:
            AppSymbols.star.name
        case .linkedDevices:
            AppSymbols.laptop.name
        case .account:
            AppSymbols.key.name
        case .privacy:
            AppSymbols.lock.name
        case .chats:
            AppSymbols.message.name
        case .notifications:
            AppSymbols.appBadge.name
        case .payments:
            AppSymbols.rupee.name
        case .storageAndData:
            AppSymbols.storage.name
        case .helpAndFeedback:
            AppSymbols.questionmarkCircle.name
        case .inviteAFriend:
            AppSymbols.heart.name
        }
    }
    
    
}
