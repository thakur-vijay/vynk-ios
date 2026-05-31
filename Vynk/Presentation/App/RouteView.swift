//
//  RouteView.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI

struct RootView: View {
    private let appDIContainer: AppDIContainer
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    var body: some View {
        switch appDIContainer.appRouter.root {
        case .splash:
            Text("Splash")
                .onAppear {
                    appDIContainer.appRouter.showMain()
                }
            
        case .auth:
            appDIContainer.authDIContainer.makeAuthView()
        case .main:
            MainTabView()
        }
    }
}
