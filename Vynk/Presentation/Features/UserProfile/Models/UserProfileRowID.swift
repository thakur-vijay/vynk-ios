//
//  UserProfileRowID.swift
//  Vynk
//
//  Created by Vijay Thakur on 27/05/26.
//

import Foundation

enum UserProfileRowID: RowIDProtocol {
    case media
    case storage
    case starred
    case notifications
    case chatTheme
    case saveToPhotos
    case disappearingMessages
    case lockChat
    case advancedChatPrivacy
    case encryption
    case contactDetails
    case shareContact
    case addToFavourites
    case addToList
    case exportChat
    case clearChat
    case block
    case report
    
    var symbol: String? {
        switch self {
        case .media: AppIcons.photo
        case .storage: AppIcons.storage
        case .starred: AppIcons.star
        case .notifications: AppIcons.bell
        case .chatTheme: AppIcons.palette
        case .saveToPhotos: AppIcons.download
        case .disappearingMessages: AppIcons.timer
        case .lockChat: AppIcons.lockOpen
        case .advancedChatPrivacy: AppIcons.shield
        case .encryption: AppIcons.lock
        case .contactDetails: AppIcons.personCircle
        default: nil
        }
    }
}
