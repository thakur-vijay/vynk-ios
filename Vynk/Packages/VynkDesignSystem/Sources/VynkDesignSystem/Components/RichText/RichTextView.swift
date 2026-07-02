//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

public struct RichTextView: View {
    let configuration: RichTextConfiguration
    let action: (String)->()

    public init(configuration: RichTextConfiguration, action: @escaping (String) -> Void) {
        self.configuration = configuration
        self.action = action
    }
    
    
    public var body: some View {
        Text(attributedText)
            .environment(\.openURL, OpenURLAction { url in
                action(url.absoluteString)
                return .handled

            })
    }
    
    private var attributedText: AttributedString {

        var attributedString = AttributedString(configuration.text)

        for link in configuration.links {

            guard
                let range = attributedString.range(of: link.text),
                let url = URL(string: link.link)
            else {
                continue
            }

            attributedString[range].link = url
            attributedString[range].font = AppFont.bodyMedium
            attributedString[range].foregroundColor = configuration.linkColor
            attributedString[range].underlineStyle = .none
        }

        return attributedString
    }
}

