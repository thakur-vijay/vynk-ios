//
//  SettingsRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 27/05/26.
//

import Foundation

protocol RowIDProtocol: Hashable {
    var symbol: String? { get }
}

struct SectionRowModel<ID: RowIDProtocol>: Identifiable, Equatable {
    let id: ID
    let title: String
    let subtitle: String?
    let trailingText: String?
    let kind: SectionRowKind
    let showsChevron: Bool
    let isTapEnabled: Bool
    
    init(id: ID, title: String, subtitle: String? = nil, trailingText: String? = nil, kind: SectionRowKind, showsChevron: Bool = true, isTapEnabled: Bool = true) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.trailingText = trailingText
        self.kind = kind
        self.showsChevron = showsChevron
        self.isTapEnabled = isTapEnabled
    }
}

enum SectionRowKind: Equatable {
    case navigation
    case toggle(isOn: Bool)
    case action(style: SectionActionStyle = .normal)
    case destructive
}

enum SectionActionStyle: Equatable {
    case normal
    case accent
}
