//
//  MessageThreadRowModel.swift
//  VynkMessageThreadKit
//
//  Created by Vijay Thakur on 16/07/26.
//


import Foundation

public struct MessageThreadModel: Identifiable, Hashable{

    public let id: String
    
    public let kind: MessageThreadKind

    public let avatarImage: String

    public let title: String

    public let lastMessage: String

    public let timestampText: String

    public let unreadCount: Int

    public let isPinned: Bool

    public let isMuted: Bool
    
    public let isYou: Bool
    
    public let isLastMessageDelivered: Bool
    
    public let isLastMessageSeen: Bool
    
    public init(id: String, kind: MessageThreadKind, avatarImage: String, title: String, lastMessage: String, timestampText: String, unreadCount: Int, isPinned: Bool, isMuted: Bool, isYou: Bool, isLastMessageDelivered: Bool, isLastMessageSeen: Bool) {
        self.id = id
        self.kind = kind
        self.avatarImage = avatarImage
        self.title = title
        self.lastMessage = lastMessage
        self.timestampText = timestampText
        self.unreadCount = unreadCount
        self.isPinned = isPinned
        self.isMuted = isMuted
        self.isYou = isYou
        self.isLastMessageDelivered = isLastMessageDelivered
        self.isLastMessageSeen = isLastMessageSeen
    }

}
