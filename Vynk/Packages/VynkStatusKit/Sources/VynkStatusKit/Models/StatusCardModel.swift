//
//  StatusCardModel.swift
//  VynkStatusKit
//
//  Created by Vijay Thakur on 15/07/26.
//

import Foundation

public struct StatusCardModel: Identifiable, Hashable {

    public let id: String
    public let user: StatusUserModel
    public let statuses: [StatusItemModel]
    public let isCurrentUser: Bool

    public init(
        id: String,
        user: StatusUserModel,
        statuses: [StatusItemModel],
        isCurrentUser: Bool
    ) {
        self.id = id
        self.user = user
        self.statuses = statuses
        self.isCurrentUser = isCurrentUser
    }
}

