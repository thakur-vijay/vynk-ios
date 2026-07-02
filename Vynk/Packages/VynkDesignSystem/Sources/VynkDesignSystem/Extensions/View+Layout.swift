//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func fillWidth(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func fillHeight(_ alignment: Alignment = .center)-> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func frame(_ size: CGSize)-> some View {
        self
            .frame(width: max(size.width, 0), height: max(size.height, 0))
    }
}
