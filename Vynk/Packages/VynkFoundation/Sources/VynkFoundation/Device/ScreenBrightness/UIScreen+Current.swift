//
//  File.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//

import UIKit

public extension UIScreen {

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
