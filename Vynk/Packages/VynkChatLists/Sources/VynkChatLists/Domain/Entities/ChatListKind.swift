//
//  ChatListType.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import Foundation

public enum ChatListKind: String, Codable, Sendable, Equatable{
    case favorites
    case unread
    case groups
    case communities
    case custom
}

extension ChatListKind {

    nonisolated var canDelete: Bool {

        self != .favorites

    }

    nonisolated var canEdit: Bool {

        self == .custom

    }

}

extension ChatListKind {
    nonisolated var isPreset: Bool {
        switch self {
        case .unread, .groups, .communities:
            true
        case .favorites, .custom:
            false
        }
    }

    nonisolated static var presetKinds: [ChatListKind] {
        [.unread, .groups, .communities]
    }
}
