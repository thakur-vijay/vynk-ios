//
//  SwiftUIView.swift
//  VynkChannelKit
//
//  Created by Vijay Thakur on 16/07/26.
//

import ComposableArchitecture
import Foundation
import VynkMessageThreadKit

@Reducer
public struct ChannelRowFeature {

    @ObservableState
    public struct State: Equatable, Identifiable {
        public var model: MessageThreadModel

        public var id: String {
            model.id
        }

        public init(model: MessageThreadModel) {
            self.model = model
        }
    }

    public enum Action {
        case tapped

        case markUnreadTapped
        case pinTapped
        case archiveTapped
        case moreTapped

        case contextMenu(ChannelContextAction)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            
            case openConversation(MessageThreadModel)
            
        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case .tapped:
                return .send(.delegate(.openConversation(state.model)))

            case .markUnreadTapped:
                return .none

            case .pinTapped:
                return .none

            case .archiveTapped:
                return .none

            case .moreTapped:
                return .none

            case .contextMenu:
                return .none
            case .delegate:
                return .none
            }
        }
    }
}
