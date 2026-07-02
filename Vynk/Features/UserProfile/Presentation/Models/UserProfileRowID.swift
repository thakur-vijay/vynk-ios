//
//  UserProfileRowID.swift
//  Vynk
//
//  Created by Vijay Thakur on 27/05/26.
//

import Foundation

enum UserProfileRowID: @MainActor RowIDProtocol {
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
        case .media: AppSymbols.photo.name
        case .storage: AppSymbols.storage.name
        case .starred: AppSymbols.star.name
        case .notifications: AppSymbols.bell.name
        case .chatTheme: AppSymbols.palette.name
        case .saveToPhotos: AppSymbols.download.name
        case .disappearingMessages: AppSymbols.timer.name
        case .lockChat: AppSymbols.lockOpen.name
        case .advancedChatPrivacy: AppSymbols.shield.name
        case .encryption: AppSymbols.lock.name
        case .contactDetails: AppSymbols.personCircle.name
        default: nil
        }
    }
}
