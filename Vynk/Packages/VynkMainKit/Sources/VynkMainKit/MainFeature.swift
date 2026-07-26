//
//  SwiftUIView.swift
//  VynkMainKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture
import VynkUpdatesKit
import VynkCallsKit
import VynkCommunitiesKit
import VynkChatsKit
import VynkSettingsKit
import VynkSecurity
import VynkAppLockKit
import SwiftUI

@Reducer
public struct MainFeature {
    
    @Dependency(\.appLockManager)
    private var appLockManager
    
    @ObservableState
    public struct State: Equatable {
        public var selectedTab: AnimatedTab = .chats
        
        public var updates = UpdatesFeature.State()
        public var calls = CallsFeature.State()
        public var communities = CommunitiesFeature.State()
        public var chats = ChatsFeature.State()
        public var settings = SettingsFeature.State()
        
        public var appLock: AppLockFeature.State?
        public init(){
            
        }
    }
    
    public enum Action: BindableAction{
        case binding(BindingAction<State>)
        
        case updates(UpdatesFeature.Action)
        case calls(CallsFeature.Action)
        case communities(CommunitiesFeature.Action)
        case chats(ChatsFeature.Action)
        case settings(SettingsFeature.Action)
        
        case appLock(AppLockFeature.Action)
        
        case scenePhaseChanged(ScenePhase)
        case shouldLock
        
        case delegate(Delegate)

        public enum Delegate: Equatable {
            case logoutSucceeded
        }
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(\.updates, action: \.updates) {
            UpdatesFeature()
        }
//        
        Scope(\.calls, action: \.calls) {
            CallsFeature()
        }
//        
        Scope(\.communities, action: \.communities) {
            CommunitiesFeature()
        }
//        
        Scope(\.chats, action: \.chats) {
            ChatsFeature()
        }
//        
        Scope(\.settings, action: \.settings) {
            SettingsFeature()
        }
//        
        Reduce { state, action in
            let appLockManager = appLockManager
            switch action {
            case .settings(.logoutTapped):
                return .send(.delegate(.logoutSucceeded))
            case .settings(.delegate(.openChat)):
                state.settings.path.removeAll()
                state.selectedTab = .chats

                return .send(
                    .chats(
                        .openConversation(MockChats.list.first!)
                    )
                )
            case .binding:
                return .none

            case .delegate:
                return .none

            case .updates,
                 .calls,
                 .communities,
                 .chats,
                 .settings:
                return .none

            case let .scenePhaseChanged(phase):
                print(phase)
                switch phase {
                    
                case .background:
                    return .run { _ in
                        await appLockManager.didEnterBackground()
                    }
                    
                case .active:
                    
                    return .run { send in
                        await appLockManager.didBecomeActive()
                        if await appLockManager.shouldShowLockScreen {
                            print("lock")
                            await send(.shouldLock)
                        }else {
                            print("unlock")
                        }
                    }
                case .inactive:
                    
                    return .none
                    
                @unknown default:
                    
                    return .none
                    
                }
            case .shouldLock:
                state.appLock = AppLockFeature.State()
                return .none
            case let .appLock(action):
                switch action {
                case .delegate(.unlocked):
                    state.appLock = nil
                    return .none

                default:
                    return .none
                }
            }
        }
        .ifLet(\.appLock, action: \.appLock) {
            AppLockFeature()
        }
    }
}
