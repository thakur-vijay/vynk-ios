//
//  MessageRowBuilder.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import Foundation

public enum MessageRowBuilder {
    public static func build(from messages: [MessageModel]) -> [MessageRowModel] {
        messages.enumerated().map { index, message in
            let previous = index > 0 ? messages[index - 1] : nil
            let next = index < messages.count - 1 ? messages[index + 1] : nil
            
            return MessageRowModel(
                id: message.id,
                message: message,
                isFirstInGroup: previous?.isCurrentUser != message.isCurrentUser,
                isLastInGroup: next?.isCurrentUser != message.isCurrentUser
            )
        }
    }
}
