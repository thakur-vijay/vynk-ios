//
//  SectionRowKind.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 13/07/26.
//

import Foundation

public enum SectionRowKind: Equatable {
    case navigation
    case toggle
    case action(style: SectionActionStyle = .normal)
    case destructive
}
