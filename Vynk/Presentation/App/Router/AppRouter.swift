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
    
    init() {
        
        chatsRouter = .init()
        
        settingsRouter = .init()
        
    }
    
    enum Root {
        case splash
        case auth
        case main
    }
    
    var root: Root = .splash
    var activeTab: AnimatedTab = .chats
    
    func showAuth(){
        root = .auth
    }
    
    func showMain(){
        root = .main
    }
    
    func selectTab(_ tab: AnimatedTab) {
        activeTab = tab
        
    }
     
    func openChat() {
        settingsRouter.popToRoot()

        activeTab = .chats

        chatsRouter.push(.detail(MockDataFactory.chats.first!))
    }
}
