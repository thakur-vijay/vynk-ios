//
//  MediaRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

@MainActor
@Observable
final class MediaRouter {
    var path = NavigationPath()
    
    func push(_ route: MediaRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
        
    }
    
    func popToRoot() {
        path = NavigationPath()
        
    }
}
