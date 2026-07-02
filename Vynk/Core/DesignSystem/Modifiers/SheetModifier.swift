//
//  SheetModifier.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func fixedSheet()-> some View {
        self
            .modifier(SheetModifier())
    }
}

struct SheetModifier: ViewModifier {
    @State private var sheetHeight: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .presentationDetents([.medium])
            .presentationBackground(.white)
    }
}
