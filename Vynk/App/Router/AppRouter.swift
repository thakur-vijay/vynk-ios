//
//  AppRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI

@MainActor
@Observable
final class AppRouter: ChatNavigator{
    
    let chatsRouter: ChatsRouter

    let settingsRouter: SettingsRouter
    
    var navigationRequest: PendingNavigation?
    
    init() {
        
        chatsRouter = .init()
        
        settingsRouter = .init()
        
    }
    
    enum Root {
        case auth
        case main
    }
    
    var root: Root = .auth
//    var activeTab: AnimatedTab = .chats
    
    func showAuth(){
        root = .auth
    }
    
    func showMain(){
        root = .main
    }
    
//    func selectTab(_ tab: AnimatedTab) {
//        activeTab = tab
//        
//    }
     
    func openChat()async {

        settingsRouter.popToRoot()
        
        await Task.yield()
        
//        activeTab = .chats
        
        await Task.yield()

        navigationRequest = .openChat
    }
}
