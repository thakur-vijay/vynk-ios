//
//  AppFont.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import SwiftUI

public enum AppFont {

    // MARK: - Large Titles

    public static let largeTitle = Font.largeTitle.weight(.bold)

    public static let title1 = Font.title.weight(.bold)
    public static let title1Regular = Font.title.weight(.regular)

    public static let title2 = Font.title2.weight(.bold)
    public static let title2Regular = Font.title2.weight(.regular)

    public static let title3 = Font.title3.weight(.semibold)

    // MARK: - Headlines

    public static let headline = Font.headline.weight(.semibold)

    public static let subheadline = Font.subheadline

    // MARK: - Body

    public static let body = Font.body

    public static let bodyMedium = Font.body.weight(.medium)

    public static let bodySemibold = Font.body.weight(.semibold)

    // MARK: - Caption

    public static let caption = Font.caption

    public static let captionMedium = Font.caption.weight(.medium)

    public static let captionSemibold = Font.caption.weight(.semibold)

    // MARK: - Footnote

    public static let footnote = Font.footnote

    public static let footnoteMedium = Font.footnote.weight(.medium)
    
    public static let callout = Font.callout

    public static let calloutMedium = Font.callout.weight(.medium)

    public static let caption2 = Font.caption2
}
