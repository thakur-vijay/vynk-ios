//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct ConversationFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var model: MessageThreadRowModel
        var input = ConversationInputFeature.State()
        var header: ConversationHeaderFeature.State
        public var messages = MessageModel.sampleList
        
        public var rows: [MessageRowModel] {
            MessageRowBuilder.build(from: messages)
        }
        
        public var messageSections: [MessageSection] {
            MessageGroupingHelper.groupMessagesByDay(messages)
        }
        
        public init(model: MessageThreadRowModel){
            self.model = model
            self.header = ConversationHeaderFeature.State(model: model)
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case input(ConversationInputFeature.Action)
        case header(ConversationHeaderFeature.Action)
        
        case delegate(Delegate)
        
        public enum Delegate {
            case openUserProfile
        }
    }
    
    public var body: some ReducerOf<Self> {
        Scope(\.input, action: \.input) {
            ConversationInputFeature()
        }
        Scope(\.header, action: \.header) {
            ConversationHeaderFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .input(.delegate(.sendMessage(let message))):
                state.messages.append(
                    MessageModel(
                        id: UUID().uuidString,
                        text: message,
                        sentAt: .now,
                        isCurrentUser: true,
                        status: .sending,
                        type: .text
                    )
                )
                return .none
            case .input, .delegate:
                return .none
            case .binding:
                return .none
            case .header(.delegate(.didTapUserInfo)):
                return .send(.delegate(.openUserProfile))
            case .header: return .none
            }
        }
    }
    
}
