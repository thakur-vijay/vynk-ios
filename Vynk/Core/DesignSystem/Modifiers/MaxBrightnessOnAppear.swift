//
//  MaxBrightnessOnAppear.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI

struct ScreenBrightnessModifier: ViewModifier {

    @State private var previousBrightness: CGFloat?

    func body(content: Content) -> some View {
        content
            .onAppear {

                guard let screen = UIScreen.current else {
                    return
                }

                previousBrightness = screen.brightness
                screen.brightness = 1.0
            }
            .onDisappear {

                guard
                    let screen = UIScreen.current,
                    let previousBrightness
                else {
                    return
                }

                screen.brightness = previousBrightness
            }
    }
}

extension View {
    func maxBrightnessOnAppear() -> some View {
        modifier(ScreenBrightnessModifier())
    }
}
