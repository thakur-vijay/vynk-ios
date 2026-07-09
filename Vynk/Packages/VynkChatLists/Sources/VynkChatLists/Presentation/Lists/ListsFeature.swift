//
//  File.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 05/07/26.
//

import ComposableArchitecture

@Reducer
internal struct ListsFeature{
    
    @Dependency(\.chatListsClient)
    private var chatListsClient
    
    @ObservableState
    struct State: Equatable {
        var lists: [ChatListRowModel] = []
        var availablePresets: [ChatListRowModel] = []
        var isCustomListsEmpty: Bool {
            lists.first { $0.kind == .custom } == nil
        }
        init() {
            
        }
        
        @Presents
        var destination: Destination.State?
    }
    
    enum Action {
        case onTask
        case onDisappear
        case visibleListsResponse([ChatList])
        case availablePresetsResponse([ChatList])
        case restorePresetTapped(String)
        case destination(PresentationAction<Destination.Action>)
        case createListButtonTapped
        case reorderButtonTapped
    }
    
    init(){
        
    }
    
    private enum CancelID {
        case observations
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            let client = chatListsClient
            switch action {
            case .onTask:
                return .merge(

                    .run { send in
                        for try await lists in client.observeVisibleLists() {
                            await send(.visibleListsResponse(lists))
                        }
                    }
                    .cancellable(id: CancelID.observations),

                    .run { send in
                        for try await presets in client.observeAvailablePresets() {
                            await send(.availablePresetsResponse(presets))
                        }
                    }
                    .cancellable(id: CancelID.observations)
                )
            case .visibleListsResponse(let lists):
                state.lists = lists.map({ model in
                    ChatListRowModel(model)
                })
                return .none
            case .availablePresetsResponse(let presets):
                state.availablePresets = presets.map({ model in
                    ChatListRowModel(model)
                })
                return .none
            case let .restorePresetTapped(id):
                return .run { _ in
                    try await client.restorePreset(id)
                }
            case .onDisappear:
                return .cancel(id: CancelID.observations)
            case .createListButtonTapped:
                state.destination = .listEditor(
                    ListEditorFeature.State(mode: .create)
                )
                return .none
            case .reorderButtonTapped:
                state.destination = .reorderLists(
                    ReorderListsFeature.State()
                )
                return .none
            case .destination(.presented(.listEditor(.saveCompleted))):
                state.destination = nil
                return .none
            case .destination(_):
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
}
