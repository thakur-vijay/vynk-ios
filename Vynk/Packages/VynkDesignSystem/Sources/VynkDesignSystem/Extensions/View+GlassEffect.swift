//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func glassEffect<S: Shape>(_ shape: S)-> some View {
        if #available(iOS 26, *){
            self
                .glassEffect(.regular.interactive(), in: shape)
        }else {
            self
                .background(.ultraThinMaterial, in: shape)
        }
    }
}
