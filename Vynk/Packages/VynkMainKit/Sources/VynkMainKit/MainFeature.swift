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

@Reducer
public struct MainFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var selectedTab: AnimatedTab = .chats
        
        public var updates = UpdatesFeature.State()
        public var calls = CallsFeature.State()
        public var communities = CommunitiesFeature.State()
        public var chats = ChatsFeature.State()
        public var settings = SettingsFeature.State()
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
        
        Scope(\.calls, action: \.calls) {
            CallsFeature()
        }
        
        Scope(\.communities, action: \.communities) {
            CommunitiesFeature()
        }
        
        Scope(\.chats, action: \.chats) {
            ChatsFeature()
        }
        
        Scope(\.settings, action: \.settings) {
            SettingsFeature()
        }
        
        Reduce { state, action in
            switch action {

            case .settings(.logoutTapped):
                return .send(.delegate(.logoutSucceeded))

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
            }
        }
    }
}
