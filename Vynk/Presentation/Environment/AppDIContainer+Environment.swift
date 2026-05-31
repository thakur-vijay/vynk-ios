//
//  AppDIContainer+Environment.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

private struct AppDIContainerKey: EnvironmentKey {
    static let defaultValue = AppDIContainer()
}

extension EnvironmentValues {
    
    var appDIContainer: AppDIContainer {
        get { self[AppDIContainerKey.self] }
        set { self[AppDIContainerKey.self] = newValue }
    }
}
