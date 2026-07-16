//
//  StatusItemModel.swift
//  VynkStatusKit
//
//  Created by Vijay Thakur on 15/07/26.
//

import Foundation

public struct StatusItemModel: Identifiable, Hashable {

    public let id: String

    public let mediaURL: String

    public let type: StatusItemType

    public let createdAt: Date
    
    public init(id: String, mediaURL: String, type: StatusItemType, createdAt: Date) {
        self.id = id
        self.mediaURL = mediaURL
        self.type = type
        self.createdAt = createdAt
    }

}
