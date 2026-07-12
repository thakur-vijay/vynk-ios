//
//  MessageSection.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import Foundation

public struct MessageSection: Identifiable {

    public let id: Date

    public let title: String

    public let messages: [MessageModel]

}
