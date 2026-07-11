//
//  SwiftUIView.swift
//  VynkCallsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture

@Reducer
public struct CallsFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var search: String = ""
        public init(){}
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    public init(){}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding: return .none
            }
        }
    }
}
