//
//  RouteView.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI

struct RootView: View {
    
    @State private var router: AppRouter
    private let appDIContainer: AppDIContainer
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
        _router = State(wrappedValue: appDIContainer.appRouter)
    }
    
    var body: some View {
        switch router.root {
        case .splash:
            Text("Splash")
                .onAppear {
                    router.showAuth()
                }
            
        case .auth:
            appDIContainer.authDIContainer.makeAuthView()
        case .main:
            Text("Main")
        }
    }
}
