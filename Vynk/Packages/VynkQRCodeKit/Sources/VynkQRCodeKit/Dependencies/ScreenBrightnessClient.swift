//
//  ScreenBrightnessClient.swift
//  VynkQRCodeKit
//
//  Created by Vijay Thakur on 18/07/26.
//

import ComposableArchitecture
import VynkFoundation

public struct ScreenBrightnessClient: Sendable {
    public var setBrightness: @MainActor (ScreenBrightness) -> Void
    public var restoreBrightness: @MainActor () -> Void

    public init(
        setBrightness: @escaping @MainActor (ScreenBrightness) -> Void,
        restoreBrightness: @escaping @MainActor () -> Void
    ) {
        self.setBrightness = setBrightness
        self.restoreBrightness = restoreBrightness
    }
}

private enum ScreenBrightnessKey: DependencyKey {
    static let liveValue = ScreenBrightnessClient(
        setBrightness: { _ in },
        restoreBrightness: { }
    )
}

public extension DependencyValues {
    var screenBrightness: ScreenBrightnessClient {
        get { self[ScreenBrightnessKey.self] }
        set { self[ScreenBrightnessKey.self] = newValue }
    }
}
