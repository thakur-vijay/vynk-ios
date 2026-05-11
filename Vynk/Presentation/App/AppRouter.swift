//
//  AppRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI

@MainActor
@Observable
final class AppRouter {
    
    init() {
        print("called")
    }
    
    enum Root {
        case splash
        case auth
        case main
    }
    
    var root: Root = .splash
    
    func showAuth(){
        root = .auth
    }
    
    func showMain(){
        root = .main
    }
}
