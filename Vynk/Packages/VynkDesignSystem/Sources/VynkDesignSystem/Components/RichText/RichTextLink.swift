//
//  RichTextLink.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//


import Foundation

public struct RichTextLink: Sendable, Hashable {

    public let text: String

    public let link: String

    public init(
        text: String,
        link: String
    ) {
        self.text = text
        self.link = link
    }
}
