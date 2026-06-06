//
//  SettingsRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

@MainActor
@Observable
final class SettingsRouter {
    var path = NavigationPath()
    var activeSheet: SettingsSheet?
    
    func push(_ route: SettingsRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
        
    }
    
    func popToRoot() {
        path = NavigationPath()
        
    }
    
    func presentSheet(_ sheet: SettingsSheet) {
        activeSheet = sheet
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
}
