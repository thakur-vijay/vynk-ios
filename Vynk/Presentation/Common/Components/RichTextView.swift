//
//  RichTextView.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import SwiftUI

struct RichTextView: View {

    let message: String
    let metadata: [String: String]
    let attributionColor: Color
    let action: (String)->()

    var body: some View {
        Text(attributedText)
            .environment(\.openURL, OpenURLAction { url in
                action(url.absoluteString)
                return .handled

            })
    }
    
    var attributedText: AttributedString {

        var attributedString = AttributedString(message)

        for (text, urlString) in metadata {

            guard
                let range = attributedString.range(of: text),
                let url = URL(string: urlString)
            else {
                continue
            }

            attributedString[range].link = url
            attributedString[range].font = AppFont.bodyMedium
            attributedString[range].foregroundColor = attributionColor
            attributedString[range].underlineStyle = .none
        }

        return attributedString
    }
}
