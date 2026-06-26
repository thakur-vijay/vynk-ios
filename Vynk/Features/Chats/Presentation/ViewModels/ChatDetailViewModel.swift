//
//  ChatDetailViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import SwiftUI

@MainActor
@Observable
final class ChatDetailViewModel {
    var text = ""
    var messages = MessageModel.sampleList
    
    var rows: [MessageRowModel] {
        MessageRowBuilder.build(from: messages)
    }
    
    func sendMessage() {
        messages.append(
            MessageModel(
                id: UUID().uuidString,
                text: text,
                sentAt: .now,
                isCurrentUser: true,
                status: .sending,
                type: .text
            )
        )
        
        text = ""
    }
    
    var messageSections: [MessageSection] {
        MessageGroupingHelper.groupMessagesByDay(messages)
    }
}
