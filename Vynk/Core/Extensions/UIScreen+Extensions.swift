//
//  UIScreen+Extensions.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI

extension UIScreen {

    static var current: UIScreen? {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first(where: \.isKeyWindow)?
            .windowScene?
            .screen
    }
}
