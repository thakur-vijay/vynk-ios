//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import ComposableArchitecture

@Reducer
public struct UserProfileFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var header = UserProfileHeaderFeature.State()
        public var quickActions = UserQuickActionsFeature.State()
        public init(){
            
        }
    }
    
    public enum Action {
        case header(UserProfileHeaderFeature.Action)
        case quickActions(UserQuickActionsFeature.Action)
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        Scope(\.header, action: \.header) {
            UserProfileHeaderFeature()
        }
        
        Scope(\.quickActions, action: \.quickActions) {
            UserQuickActionsFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
