//
//  File.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//

import Foundation

public enum ScreenBrightness: Sendable {
    case system
    case maximum
    case custom(CGFloat)
}


extension ScreenBrightness {

    var value: CGFloat? {

        switch self {

        case .system:
            return nil

        case .maximum:
            return 1

        case .custom(let value):
            return value
        }
    }

}
