//
//  NewChatRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import SwiftUI

@MainActor
@Observable
final class NewChatRouter {
    var path = NavigationPath()
    var activeSheet: NewChatSheet?
    
    func push(_ route: NewChatRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
        
    }
    
    func popToRoot() {
        path = NavigationPath()
        
    }
    
    func presentSheet(_ sheet: NewChatSheet) {
        activeSheet = sheet
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
}
