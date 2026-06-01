//
//  QuickActionModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

struct QuickActionModel<ID: Hashable>: Identifiable {
    let id: ID
    let title: String
    let subtitle: String?
    let symbol: String
    
    init(id: ID, title: String, subtitle: String? = nil, symbol: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.symbol = symbol
    }
}

