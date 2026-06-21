//
//  ChatListRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation

struct ChatListRowModel: Identifiable {

    let id: String
    let title: String
    let kind: ChatListKind

    let canDelete: Bool
    let canEdit: Bool
    var isSelected: Bool = false
}
