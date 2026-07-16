//
//  StatusUserModel.swift
//  VynkStatusKit
//
//  Created by Vijay Thakur on 15/07/26.
//

import Foundation

public struct StatusUserModel: Identifiable, Hashable {

    public let id: String

    public let name: String

    public let avatarURL: String

    public init(id: String, name: String, avatarURL: String) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
    }
}
