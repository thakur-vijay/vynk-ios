//
//  MessageThreadRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 30/05/26.
//

import Foundation

struct MessageThreadRowModel: Identifiable, Hashable{

    let id: String = UUID().uuidString

    let avatarImage: String

    let title: String

    let lastMessage: String

    let timestampText: String

    let unreadCount: Int

    let isPinned: Bool

    let isMuted: Bool
    
    let isYou: Bool
    
    let isLastMessageDelivered: Bool
    
    let isLastMessageSeen: Bool

}
