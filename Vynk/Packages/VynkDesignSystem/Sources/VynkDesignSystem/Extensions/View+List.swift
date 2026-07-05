//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

@available(iOS 17.0, *)
public extension View {

    @ViewBuilder
    func clearListRowStyle(
        separator: Visibility = .hidden
    ) -> some View {
        self
            .listRowSeparator(separator)
            .listRowInsets(
                EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )
            )
            .listRowBackground(EmptyView())
    }
}
