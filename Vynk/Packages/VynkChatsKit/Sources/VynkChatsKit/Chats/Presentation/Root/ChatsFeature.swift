//
//  SwiftUIView.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture
import Foundation
import VynkChatLists

@Reducer
public struct ChatsFeature {
    
    @Dependency(\.chatsClient)
    private var client
    
    @ObservableState
    public struct State: Equatable {
        public var isSearchPresented: Bool = false
        public var isPermissionStatusCardHidden: Bool = false
        public var search: String = ""
        public var lists: [ChatList] = []
        var chats: IdentifiedArrayOf<ChatRowFeature.State> =
            .init(uniqueElements: MockChats.list.map(ChatRowFeature.State.init))
        public var path = StackState<Path.State>()

        public init(){
            
        }
    }
    
    public enum Action: BindableAction{
        case binding(BindingAction<State>)
        case path(StackActionOf<Path>)
        
        case onTask
        case onDisappear
        case visibleListsResponse([ChatList])
        case listTapped(ChatFilterBarAction)
        case newChatTapped
        case cameraTapped
        case chats(IdentifiedActionOf<ChatRowFeature>)
        
        case delegate(Delegate)

        public enum Delegate: Equatable {
            case loginSucceeded
        }
    }
    
    @Reducer
    public enum Path {
    }
    
    public init(){
        
    }
    
    private enum CancelID {
        case observations
    }
    
    public var body: some ReducerOf<Self>{
        BindingReducer()
        Reduce { state, action in
            let client = client
            switch action {
            case .onTask:
                return .run { send in
                    for try await lists in client.observeVisibleLists(){
                        await send(.visibleListsResponse(lists))
                    }
                }
                .cancellable(id: CancelID.observations)
            case .binding(_):
                return .none
            case .path(_):
                return .none
            case .onDisappear:
                return .cancel(id: CancelID.observations)
            case .visibleListsResponse(let lists):
                state.lists = lists
                return .none
            case .listTapped:
                return .none
            case .newChatTapped:
                return .none
            case .cameraTapped:
                return .none
            case .chats(let action):
                return .none
            case .delegate(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .forEach(\.chats, action: \.chats) {
            ChatRowFeature()
        }
    }
}

extension ChatsFeature.Path.State: Equatable { }
