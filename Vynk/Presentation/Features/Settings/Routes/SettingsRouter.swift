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
    private var stack: [SettingsRoute] = []
    var activeSheet: SettingsSheet?
    
    func push(_ route: SettingsRoute) {
        path.append(route)
        stack.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
        guard !stack.isEmpty else { return }
        stack.removeLast()
        
    }
    
    func popToRoot() {
        path = NavigationPath()
        stack = .init()
    }
    
    func presentSheet(_ sheet: SettingsSheet) {
        activeSheet = sheet
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
    
    var toolbarVisiblity: Visibility {
        return stack.contains(.row(.lists)) ? .hidden : .visible
    }
}
