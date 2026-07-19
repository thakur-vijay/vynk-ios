//
//  ScreenBrightnessManaging.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//

import UIKit

@MainActor
public protocol ScreenBrightnessManaging: Sendable{
    func setBrightness(_ brightness: ScreenBrightness)
    func restoreBrightness()
}

@MainActor
public final class ScreenBrightnessManager: ScreenBrightnessManaging {

    private var previousBrightness: CGFloat?
    
    public init() {
        self.previousBrightness = nil
    }

    public func setBrightness(_ brightness: ScreenBrightness) {
        guard
            let screen = UIScreen.current,
            let value = brightness.value
        else {
            return
        }

        if previousBrightness == nil {
            previousBrightness = screen.brightness
        }

        screen.brightness = value
    }

    public func restoreBrightness() {
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
