//
//  AnimatedTab.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import Foundation

enum AnimatedTab: String, CaseIterable, Hashable {
    case updates
    case calls
    case communities
    case chats
    case settings
    
    var title: String {
        switch self {
        case .updates: "Updates"
        case .calls: "Calls"
        case .communities: "Communities"
        case .chats: "Chats"
        case .settings: "Settings"
        }
    }
    
    
    var symbolImage: String {
        switch self {
        case .updates: AppSymbols.dashedCircle.name
        case .calls: AppSymbols.calls.name
        case .communities: AppSymbols.group.name
        case .chats: AppSymbols.messageFill.name
        case .settings: AppSymbols.settings.name
        }
    }
}
