//
//  AppDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation


@MainActor
final class AppDIContainer {
    lazy var appRouter: AppRouter = {
        AppRouter()
    }()
    
    lazy var authDIContainer: AuthDIContainer = {
        AuthDIContainer()
    }()
}
