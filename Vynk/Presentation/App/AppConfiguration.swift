//
//  AppConfiguration.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

struct AppConfiguration {
    static let shared = AppConfiguration()
    
    let baseURL: URL = .init(string: "https://api.vynk.app")!
}
