//
//  File.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//

import UIKit

public enum AppSettings {

    @MainActor public static func open() {

        guard let url = URL(
            string: UIApplication.openSettingsURLString
        ) else {
            return
        }

        guard UIApplication.shared.canOpenURL(url) else {
            return
        }

        UIApplication.shared.open(url)

    }
}
