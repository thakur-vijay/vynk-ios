//
//  CameraZoomPreset.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import CoreFoundation

public enum CameraZoomPreset: Sendable, Hashable {
    case pointFive
    case one
    case two

    public var title: String {
        switch self {
        case .pointFive: "0.5x"
        case .one: "1x"
        case .two: "2x"
        }
    }

    public var zoomFactor: CGFloat {
        switch self {
        case .pointFive:
            1.0        // DualWide wide-looking view
        case .one:
            2.0       // tune this: maybe 1.5, 1.7, 2.0
        case .two:
            3.4        // usually 1x factor * 2
        }
    }
}
