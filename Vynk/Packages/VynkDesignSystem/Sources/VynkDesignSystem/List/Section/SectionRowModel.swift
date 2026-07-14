//
//  SectionRowModel.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 13/07/26.
//

import Foundation

public struct SectionRowModel<ID: Hashable>: Identifiable, Equatable {
    public let id: ID
    public let title: String
    public let symbol: String?
    public let subtitle: String?
    public let trailingText: String?
    public let kind: SectionRowKind
    public let showsChevron: Bool
    public let isTapEnabled: Bool
    
    public init(
        id: ID,
        title: String,
        symbol: String? = nil,
        subtitle: String? = nil,
        trailingText: String? = nil,
        kind: SectionRowKind = .navigation,
        showsChevron: Bool = true,
        isTapEnabled: Bool = true
    ) {
        self.id = id
        self.title = title
        self.symbol = symbol
        self.subtitle = subtitle
        self.trailingText = trailingText
        self.kind = kind
        self.showsChevron = showsChevron
        self.isTapEnabled = isTapEnabled
    }
}
