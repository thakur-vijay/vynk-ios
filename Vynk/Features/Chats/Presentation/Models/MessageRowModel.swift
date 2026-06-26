//
//  MessageRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import Foundation

struct MessageRowModel: Identifiable, Hashable {
    let id: String
    let message: MessageModel
    let isFirstInGroup: Bool
    let isLastInGroup: Bool
}
