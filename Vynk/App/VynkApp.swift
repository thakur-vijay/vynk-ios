//
//  VynkApp.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI
import VynkRootKit

@main
struct VynkApp: App {
    @State private var appDIContainer = AppDIContainer()
    var body: some Scene {
        WindowGroup {
            appDIContainer.rootDIContainer.makeView()
                .environment(\.appDIContainer, appDIContainer)
        }
    }
    
}
