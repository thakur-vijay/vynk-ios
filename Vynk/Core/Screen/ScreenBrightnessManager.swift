//
//  ScreenBrightnessManager.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import Foundation
import UIKit

@MainActor
protocol ScreenBrightnessManaging {
    func setFullBrightness()
    func restoreBrightness()
}

@MainActor
final class ScreenBrightnessManager:
    ScreenBrightnessManaging {

    private var previousBrightness: CGFloat?

    func setFullBrightness() {
        guard let screen = UIScreen.current else {
            return
        }

        previousBrightness = screen.brightness
        screen.brightness = 1.0
    }

    func restoreBrightness() {
        guard
            let screen = UIScreen.current,
            let previousBrightness
        else {
            return
        }

        screen.brightness = previousBrightness
        self.previousBrightness = nil
    }
}
