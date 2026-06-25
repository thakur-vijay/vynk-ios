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
    var path: [ChatsRoute] = []
    var activeSheet: ChatsSheet?
    var activeFullScreenCover: ChatsFullScreenCover?
    
    func push(_ route: ChatsRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
        
    }
    
    func popToRoot() {
        path = .init()
        
    }
    
    func presentSheet(_ sheet: ChatsSheet) {
        activeSheet = sheet
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
    
    func presentFullScreenCover(_ fullScreenCover: ChatsFullScreenCover) {
        activeFullScreenCover = fullScreenCover
    }
    
    func dismissFullScreenCover() {
        activeFullScreenCover = nil
    }
    
    private var isTabBarHidden: Bool {
        !path.isEmpty
    }
    
    var tabBarVisiblity: Visibility {
        return isTabBarHidden ? .hidden : .visible
    }
    
}
