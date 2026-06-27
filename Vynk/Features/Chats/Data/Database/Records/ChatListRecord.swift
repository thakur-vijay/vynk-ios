//
//  ChatListRecord.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import VynkDatabaseKit

struct ChatListRecord: Codable, VynkFetchableRecord, VynkPersistableRecord{
    
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
    enum ColumnNames {
        static let id = VynkColumnName("id")
        static let sortOrder = VynkColumnName("sort_order")
        static let isVisible = VynkColumnName("is_visible")
        static let kind = VynkColumnName("kind")
        static let updatedAt = VynkColumnName("updated_at")
    }
}

extension ChatListRecord {
    
    nonisolated  enum Columns {

        static let id = VynkColumn("id")

        static let kind = VynkColumn("kind")

        static let title = VynkColumn("title")

        static let sortOrder = VynkColumn("sort_order")

        static let isVisible = VynkColumn("is_visible")
        
        static let createdAt = VynkColumn("created_at")
        
        static let updatedAt = VynkColumn("updated_at")

    }

}

