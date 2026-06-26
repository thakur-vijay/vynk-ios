//
//  ChatFilterChipModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import Foundation

struct ChatFilterChipModel: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let title: String
    let isSelected: Bool
    
    init(title: String = "", isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
