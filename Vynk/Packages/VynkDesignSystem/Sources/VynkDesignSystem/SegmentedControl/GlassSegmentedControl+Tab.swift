//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

@available(iOS 18.4, *)
public extension GlassSegmentedControl {
    struct Tab: Identifiable {
        var title: String
        var viewSize: CGSize = .zero
        
        public init(title: String) {
            self.title = title
        }
        
        public var id: String { title }
    }
}
