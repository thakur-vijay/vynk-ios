//
//  MessageGroupingHelper.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import Foundation

public enum MessageGroupingHelper {
    
    public static func groupMessagesByDay(
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

extension Date {
    var sectionTitle: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        }
        if calendar.isDateInYesterday(self) {
            return "Yesterday"
        }
        
        return formatted(.dateTime.weekday(.wide).day().month(.abbreviated))
    }
    
}
