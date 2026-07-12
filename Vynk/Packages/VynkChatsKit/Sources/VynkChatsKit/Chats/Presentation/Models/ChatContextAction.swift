//
//  ChatContextAction.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import Foundation
import SwiftUI
import VynkDesignSystem

public enum ChatContextAction: Identifiable{
    case unread
    case archive
    case mute
    case lock
    case favourite
    case addToList
    case block(userName: String)
    case clear
    case delete
    
    public var id: String { label }
    
    public var label: String {
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
        case .unread: AppSymbols.ChatAction.markUnreadMenu.name
        case .archive: AppSymbols.ChatAction.archiveMenu.name
        case .mute: AppSymbols.bellSlash.name
        case .lock: AppSymbols.message.name
        case .favourite: AppSymbols.heart.name
        case .addToList: AppSymbols.ChatAction.addToListMenu.name
        case .block: AppSymbols.nosign.name
        case .clear: AppSymbols.xmarkCircle.name
        case .delete: AppSymbols.trash.name
        }
    }
    
    var role: ButtonRole? {
        switch self {
        case .delete: return .destructive
        default: return nil
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
