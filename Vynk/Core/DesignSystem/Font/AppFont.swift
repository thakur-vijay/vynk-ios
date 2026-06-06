//
//  AppFont.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import SwiftUI

enum AppFont {
    
    // MARK: - Large Titles
    
    static let largeTitle = Font.system(
        size: 34,
        weight: .bold
    )
    
    static let title1 = Font.system(
        size: 28,
        weight: .bold
    )
    
    static let title2 = Font.system(
        size: 22,
        weight: .bold
    )
    
    static let title2Normal = Font.system(
        size: 22,
    )

    
    static let title3 = Font.system(
        size: 20,
        weight: .semibold
    )
    
    // MARK: - Headlines
    
    static let headline = Font.system(
        size: 17,
        weight: .semibold
    )
    
    static let subheadline = Font.system(
        size: 15,
        weight: .regular
    )
    
    // MARK: - Body
    
    static let body = Font.system(
        size: 16,
        weight: .regular
    )
    
    static let bodyMedium = Font.system(
        size: 16,
        weight: .medium
    )
    
    static let bodySemibold = Font.system(
        size: 16,
        weight: .semibold
    )
    
    // MARK: - Caption
    
    static let caption = Font.system(
        size: 13,
        weight: .regular
    )
    
    static let captionMedium = Font.system(
        size: 13,
        weight: .medium
    )
    
    static let captionSemibold = Font.system(
        size: 13,
        weight: .semibold
    )
    
    // MARK: - Footnote
    
    static let footnote = Font.system(
        size: 12,
        weight: .regular
    )
    
    static let footnoteMedium = Font.system(
        size: 12,
        weight: .medium
    )
}
