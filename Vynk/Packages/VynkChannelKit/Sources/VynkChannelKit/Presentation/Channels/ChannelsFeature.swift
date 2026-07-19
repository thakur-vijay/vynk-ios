//
//  SwiftUIView.swift
//  VynkChannelKit
//
//  Created by Vijay Thakur on 16/07/26.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct ChannelsFeature {
    
    @ObservableState
    public struct State: Equatable {
        var channels: IdentifiedArrayOf<ChannelRowFeature.State> =
            .init(uniqueElements: MockChannels.list.map(ChannelRowFeature.State.init))
        public init(){
            
        }
    }
    
    public enum Action{
        case channels(IdentifiedActionOf<ChannelRowFeature>)
    }

    public init(){
        
    }
    
    public var body: some ReducerOf<Self>{
        Reduce { state, action in
            return .none
        }
        .forEach(\.channels, action: \.channels) {
            ChannelRowFeature()
        }
    }
}
