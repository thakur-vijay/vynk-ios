//
//  MessageSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/05/26.
//

import Foundation

struct MessageSection: Identifiable {

    let id: Date

    let title: String

    let messages: [MessageModel]

}
