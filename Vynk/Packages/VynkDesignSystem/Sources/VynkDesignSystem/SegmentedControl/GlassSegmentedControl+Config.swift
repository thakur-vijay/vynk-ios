//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

@available(iOS 18.4, *)
public extension GlassSegmentedControl {
    struct Config : Sendable{
        var foregroundStyle: Color
        var tint: Color
        var refractionAmount: CGFloat
        var refractionDepth: CGFloat
        
        public init(
            foregroundStyle: Color = .white,
            tint: Color = .yellow,
            refractionAmount: CGFloat = 10,
            refractionDepth: CGFloat = 17
        ) {
            self.foregroundStyle = foregroundStyle
            self.tint = tint
            self.refractionAmount = refractionAmount
            self.refractionDepth = refractionDepth
        }
    }
}
