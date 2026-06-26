//
//  Date+Formatting.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/05/26.
//

import Foundation

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
