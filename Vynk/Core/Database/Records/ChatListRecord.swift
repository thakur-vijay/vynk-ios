//
//  ChatListRecord.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import GRDB

struct ChatListRecord: Codable, FetchableRecord, PersistableRecord{
    
    static let databaseTableName: String = "chat_lists"

    let id: String

    let kind: String

    let title: String

    let sortOrder: Int
    
    let isVisible: Bool
    
    let createdAt: Date
    
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {

           case id, kind, title

           case sortOrder = "sort_order"

           case isVisible = "is_visible"

           case createdAt = "created_at"

           case updatedAt = "updated_at"

       }

}

extension ChatListRecord {
    nonisolated  enum Columns {

        static let id = Column("id")

        static let kind = Column("kind")

        static let title = Column("title")

        static let sortOrder = Column("sort_order")

        static let isVisible = Column("is_visible")
        
        static let createdAt = Column("created_at")
        
        static let updatedAt = Column("updated_at")

    }

}
