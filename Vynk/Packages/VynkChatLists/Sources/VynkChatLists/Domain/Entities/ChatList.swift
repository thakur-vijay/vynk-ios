//
//  ChatList.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import Foundation

public struct ChatList: Identifiable, Sendable{
    public let id: String
    public let kind: ChatListKind
    public let title: String
    public let sortOrder: Int
    public let isVisible: Bool
    public let createdAt: Date
    public let updatedAt: Date
    
    
}
