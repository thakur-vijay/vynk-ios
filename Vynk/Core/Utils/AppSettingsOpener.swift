//
//  AppSettingsOpener.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//


import UIKit

enum AppSettingsOpener {

    static func open() {

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