//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import ComposableArchitecture

@Reducer
public struct ConversationInputFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var message: String = ""
        public init(){
            
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case sendMessage
        case delegate(Delegate)
        
        public enum Delegate {
            case sendMessage(String)
        }
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .sendMessage:
                let text = state.message

                guard !text.isEmpty else {
                    return .none
                }

                state.message = ""

                return .send(.delegate(.sendMessage(text)))
            case .delegate: return .none
            case .binding: return .none
            }
        }
    }
}
