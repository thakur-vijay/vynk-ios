//
//  SectionModel.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 13/07/26.
//

import Foundation

public struct SectionModel<RowID: Hashable> {
    public let header: String?
    public let footer: String?
    public let rows: [SectionRowModel<RowID>]
    
    public init(header: String? = nil, footer: String? = nil, rows: [SectionRowModel<RowID>]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
}
