//
//  AppFont.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import SwiftUI

public enum AppFont {
    
    // MARK: - Large Titles
    
    public static let largeTitle = Font.system(
        size: 34,
        weight: .bold
    )
    
    public static let title1 = Font.system(
        size: 28,
        weight: .bold
    )
    
    public static let title1Normal = Font.system(
        size: 28,
        weight: .regular
    )
    
    public static let title2 = Font.system(
        size: 22,
        weight: .bold
    )
    
    public static let title2Normal = Font.system(
        size: 22,
    )

    
    public static let title3 = Font.system(
        size: 20,
        weight: .semibold
    )
    
    // MARK: - Headlines
    
    public static let headline = Font.system(
        size: 17,
        weight: .semibold
    )
    
    public static let subheadline = Font.system(
        size: 15,
        weight: .regular
    )
    
    // MARK: - Body
    
    public static let body = Font.system(
        size: 16,
        weight: .regular
    )
    
    public static let bodyMedium = Font.system(
        size: 16,
        weight: .medium
    )
    
    public static let bodySemibold = Font.system(
        size: 16,
        weight: .semibold
    )
    
    // MARK: - Caption
    
    public static let caption = Font.system(
        size: 13,
        weight: .regular
    )
    
    public static let captionMedium = Font.system(
        size: 13,
        weight: .medium
    )
    
    public static let captionSemibold = Font.system(
        size: 13,
        weight: .semibold
    )
    
    // MARK: - Footnote
    
    public static let footnote = Font.system(
        size: 12,
        weight: .regular
    )
    
    public static let footnoteMedium = Font.system(
        size: 12,
        weight: .medium
    )
}
