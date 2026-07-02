//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

@available(iOS 26.0, *)
public extension View {
    @ViewBuilder
    func clearListRowStyle(separator: Visibility = .hidden) -> some View {
        self
            .listRowSeparator(separator)
            .listRowInsets(.all, 0)
            .listRowBackground(EmptyView())
    }
}
