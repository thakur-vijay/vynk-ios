//
//  File.swift
//  VynkPrivacyKit
//
//  Created by Vijay Thakur on 27/07/26.
//

import ComposableArchitecture

@Reducer
public struct PrivacyFeature {
    
    @ObservableState
    public struct State: Equatable {
        
        public init(){
            
        }
    }
    
    public enum Action {
        
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
