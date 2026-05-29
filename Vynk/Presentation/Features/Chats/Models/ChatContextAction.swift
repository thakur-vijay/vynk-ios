//
//  ChatContextAction.swift
//  Vynk
//
//  Created by Vijay Thakur on 30/05/26.
//

import Foundation
import SwiftUI

enum ChatContextAction: Identifiable{
    case unread
    case archive
    case mute
    case lock
    case favourite
    case addToList
    case block(userName: String)
    case clear
    case delete
    
    var id: String { label }
    
    var label: String {
        switch self {
        case .unread: "Mark as unread"
        case .archive: "Archive"
        case .mute: "Mute"
        case .lock: "Lock chat"
        case .favourite: "Add to Favourites"
        case .addToList: "Add to list"
        case .block(let name): "Block \(name)"
        case .clear: "Clear chat"
        case .delete: "Delete Chat"
        }
    }
    
    var symbol: String {
        switch self {
        case .unread: AppIcons.ChatAction.markUnreadMenu
        case .archive: AppIcons.ChatAction.archiveMenu
        case .mute: AppIcons.bellSlash
        case .lock: AppIcons.message
        case .favourite: AppIcons.heart
        case .addToList: AppIcons.ChatAction.addToListMenu
        case .block: AppIcons.nosign
        case .clear: AppIcons.xmarkCircle
        case .delete: AppIcons.trash
        }
    }
    
    var role: ButtonRole {
        switch self {
        case .delete: return .destructive
        default: return .confirm
        }
    }
    
    static func allActions(userName: String) -> [ChatContextAction] {
        [
            .unread,
            .archive,
            .mute,
            .lock,
            .favourite,
            .addToList,
            .block(userName: userName),
            .clear,
            .delete
        ]
    }
}
