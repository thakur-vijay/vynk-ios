//
//  SwiftUIView.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import Foundation

public struct DialogConfiguration {

    let title: String

    let message: String?

    let actions: [DialogAction]

    public init(title: String, message: String?, actions: [DialogAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}
