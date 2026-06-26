//
//  StatusCardModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 29/05/26.
//

import Foundation

struct StatusCardModel: Identifiable, Hashable {
    let id: String
    let user: StatusUserModel
    let statuses: [StatusItemModel]
    let isCurrentUser: Bool

}

struct StatusUserModel: Identifiable, Hashable {

    let id: String

    let name: String

    let avatarURL: String

}

struct StatusItemModel: Identifiable, Hashable {

    let id: String

    let mediaURL: String

    let type: StatusItemType

    let createdAt: Date

}

enum StatusItemType: Hashable {

    case image

    case video

    case text

}
