//
//  VynkApp.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI

@main
struct VynkApp: App {
    @State private var appDIContainer = AppDIContainer()
    var body: some Scene {
        WindowGroup {
            RootView(appDIContainer: appDIContainer)
        }
    }
}
