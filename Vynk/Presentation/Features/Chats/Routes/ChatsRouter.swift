//
//  ChatRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

@MainActor
@Observable
final class ChatsRouter {
    var path = NavigationPath()
    var activeSheet: ChatsSheet?
    
    func push(_ route: ChatsRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
        
    }
    
    func popToRoot() {
        path = NavigationPath()
        
    }
    
    func presentSheet(_ sheet: ChatsSheet) {
        activeSheet = sheet
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
}
