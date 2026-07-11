//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct ChatsFeature {
    
    @ObservableState
    public struct State: Equatable {
        var memory: Data?
        public init(){
            
        }
    }
    
    public enum Action {
        case allocateMemory
        case releaseMemory
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self>{
        Reduce { state, action in
            switch action {
            case .allocateMemory:
                state.memory = Data(count: 100 * 1024 * 1024) // 100 MB
                return .none

            case .releaseMemory:
                state.memory = nil
                return .none
            }
        }
    }
}
