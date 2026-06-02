//
//  SettingsRowID.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import Foundation

enum SettingsRowID: RowIDProtocol{
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
            AppIcons.ChatAction.addToListMenu
        case .broadcastMessages:
            AppIcons.broadcast
        case .starred:
            AppIcons.star
        case .linkedDevices:
            AppIcons.laptop
        case .account:
            AppIcons.key
        case .privacy:
            AppIcons.lock
        case .chats:
            AppIcons.message
        case .notifications:
            AppIcons.appBadge
        case .payments:
            AppIcons.rupee
        case .storageAndData:
            AppIcons.storage
        case .helpAndFeedback:
            AppIcons.questionmarkCircle
        case .inviteAFriend:
            AppIcons.heart
        }
    }
    
    
}
