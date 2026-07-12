//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct ChatRowFeature {

    @ObservableState
    public struct State: Equatable, Identifiable {
        public var model: MessageThreadRowModel

        public var id: String {
            model.id
        }

        public init(model: MessageThreadRowModel) {
            self.model = model
        }
    }

    public enum Action {
        case tapped

        case markUnreadTapped
        case pinTapped
        case archiveTapped
        case moreTapped

        case contextMenu(ChatContextAction)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            
            case openConversation(MessageThreadRowModel)
            
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
