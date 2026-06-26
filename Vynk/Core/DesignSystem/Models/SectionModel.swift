//
//  SectionModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation

struct SectionModel<ID: RowIDProtocol>: Identifiable {
    let id: String = UUID().uuidString
    let header: String?
    let footer: String?
    let rows: [SectionRowModel<ID>]
    
    init(header: String? = nil, footer: String? = nil, rows: [SectionRowModel<ID>]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
}
