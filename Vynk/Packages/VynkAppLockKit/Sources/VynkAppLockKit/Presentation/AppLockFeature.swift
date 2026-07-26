//
//  AppLockFeature.swift
//  VynkAppLockKit
//
//  Created by Vijay Thakur on 26/07/26.
//


import ComposableArchitecture
import VynkSecurity

@Reducer
public struct AppLockFeature {
    
    @Dependency(\.appLockManager)
    private var appLockManager
    
    @Dependency(\.autheticationAppLock)
    private var autheticationAppLock

    @ObservableState
    public struct State: Equatable {
        var isAuthenticating = false
        
        public init(){
            
        }
    }

    public enum Action {
        case onAppear
        case unlockTapped
        case delegate(Delegate)
        
        public enum Delegate {
            case unlocked
        }
    }
    
    public init(){
        
    }

    public var body: some ReducerOf<Self> {

        Reduce { state, action in
            let autheticationAppLock = autheticationAppLock
            let appLockManager = appLockManager
            switch action {
            case .onAppear, .unlockTapped :
                return .run { send in
                    let isUnlocked = try await autheticationAppLock.authenticate()
                    if isUnlocked {
                        await appLockManager.unlock()
                        await send(.delegate(.unlocked))
                    }
                }
            case .delegate:
                return .none
            }
        }
    }
}
