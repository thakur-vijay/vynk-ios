//
//  SwiftUIView.swift
//  VynkUpdatesKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture
import VynkStatusKit
import VynkChannelKit

@Reducer
public struct UpdatesFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var search: String = ""
        public var status = StatusesFeature.State()
        public var channels = ChannelsFeature.State()
        public init(){
            
        }
    }
    
    public enum Action: BindableAction{
        case binding(BindingAction<State>)
        case status(StatusesFeature.Action)
        case channels(ChannelsFeature.Action)
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Scope(\.status, action: \.status) {
            StatusesFeature()
        }
        Scope(\.channels, action: \.channels) {
            ChannelsFeature()
        }
        Reduce { state, action in
            return .none
        }
    }
}
