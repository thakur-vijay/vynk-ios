//
//  MessageGroupingHelper.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/05/26.
//

import Foundation

enum MessageGroupingHelper {
    
    static func groupMessagesByDay(
        _ messages: [MessageModel]
    ) -> [MessageSection] {
        
        let calendar = Calendar.current
        
        let grouped = Dictionary(grouping: messages) {
            calendar.startOfDay(for: $0.sentAt)
        }
        
        return grouped
            .map { date, messages in
                MessageSection(
                    id: date,
                    title: date.sectionTitle,
                    messages: messages.sorted {
                        $0.sentAt < $1.sentAt
                    }
                )
            }
            .sorted { $0.id < $1.id }
    }
}
