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

    public init(
        text: String,
        links: [RichTextLink],
        linkColor: Color
    ) {
        self.text = text
        self.links = links
        self.linkColor = linkColor
    }
}
