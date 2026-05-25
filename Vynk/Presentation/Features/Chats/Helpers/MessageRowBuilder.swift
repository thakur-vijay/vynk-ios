//
//  MessageRowBuilder.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import Foundation

enum MessageRowBuilder {
    static func build(from messages: [MessageModel]) -> [MessageRowModel] {
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
