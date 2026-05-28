//
//  AnimatedTab.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import Foundation

protocol AnimatedTabSelectionProtocol: CaseIterable, Hashable{
    var title: String { get }
    var symbolImage: String { get }
}

enum AnimatedTab: AnimatedTabSelectionProtocol {
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
        case .updates: AppIcons.dashedCircle
        case .calls: AppIcons.calls
        case .communities: AppIcons.group
        case .chats: AppIcons.messageFill
        case .settings: AppIcons.settings
        }
    }
}
