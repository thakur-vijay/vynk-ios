//
//  RichTextConfiguration.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

public struct RichTextConfiguration {

    public let text: String

    public let links: [RichTextLink]

    public let linkColor: Color
    
    public let font: Font
    
    public let linkFont: Font

    public init(
        text: String,
        links: [RichTextLink],
        linkColor: Color,
        font: Font,
        linkFont: Font? = nil
    ) {
        self.text = text
        self.links = links
        self.linkColor = linkColor
        self.font = font
        self.linkFont = linkFont ?? font
    }
}
