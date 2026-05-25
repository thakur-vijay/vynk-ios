//
//  MessageModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import Foundation

struct MessageModel: Identifiable, Hashable {

    let id: String

    let text: String

    let sentAt: Date

    let isCurrentUser: Bool

    let status: MessageStatus

    let type: MessageType

    

    var timestampText: String {

        sentAt.formatted(date: .omitted, time: .shortened)

    }

}
