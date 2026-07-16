//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import ComposableArchitecture
import VynkMessageThreadKit

@Reducer
public struct ConversationHeaderFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var model: MessageThreadModel
        public init(model: MessageThreadModel){
            self.model = model
        }
    }
    
    public enum Action {
        case openUserDetail
        case delegate(Delegate)
        
        public enum Delegate {
            case didTapUserInfo
        }
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .openUserDetail:
                return .send(.delegate(.didTapUserInfo))
            case .delegate: return .none
            }
        }
    }
}
