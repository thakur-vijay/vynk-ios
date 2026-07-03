//
//  RouteView.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI
import VynkSecurity

struct RootView: View {
    private let appDIContainer: AppDIContainer
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    @Environment(\.scenePhase)
    private var scenePhase
    
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
            ZStack {
                MainTabView()
                
                if appDIContainer.appLockManager.shouldShowLockScreen {
                    appDIContainer.appLockDIContainer.makeView()
                }
            }
            .environment(appDIContainer.appLockManager)
            .onChange(of: scenePhase) { oldValue, newValue in
                handleScenePhase(newValue)
            }
        }
    }
}

private extension RootView {

    func handleScenePhase(_ phase: ScenePhase) {

        switch phase {

        case .background:
            appDIContainer.appLockManager.didEnterBackground()

        case .active:
            appDIContainer.appLockManager.didBecomeActive()

        case .inactive:
            appDIContainer.appLockManager.didEnterBackground()

        @unknown default:
            break
        }
    }
}
