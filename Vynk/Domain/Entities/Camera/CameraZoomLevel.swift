//
//  CameraZoomLevel.swift
//  Vynk
//
//  Created by Vijay Thakur on 10/06/26.
//

import Foundation

enum CameraZoomLevel: Sendable, Hashable {
    case ultraWide
    case wide

    var displayTitle: String {
        switch self {
        case .ultraWide: "0.5x"
        case .wide: "1x"
        }
    }
}
