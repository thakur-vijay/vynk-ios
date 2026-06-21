//
//  ChatList.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import Foundation

struct ChatList: Identifiable{
    let id: String
    let kind: ChatListKind
    let title: String
    let sortOrder: Int
    let isVisible: Bool
    let createdAt: Date
    let updatedAt: Date
    
}
