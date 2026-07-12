//
//  ReorderListsFeature.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 05/07/26.
//

import ComposableArchitecture
import VynkDesignSystem
import Foundation

@Reducer
internal struct ReorderListsFeature {
    
    @Dependency(\.chatListsClient)
    private var chatListsClient
    
    @Dependency(\.dismiss)
    private var dismiss

    @ObservableState
    struct State: Equatable {
        public var lists: [ChatList] = []
        public var availablePresets: [ChatList] = []
        @Presents
        public var alert: AlertState<Action.Alert>?
        public var deletingList: ChatList?

        public init() {}
    }

    enum Action {
        case onTask
        case onDisappear

        case visibleListsResponse([ChatList])
        case availablePresetsResponse([ChatList])

        case move(IndexSet, Int)

        case restorePresetTapped(String)

        case closeButtonTapped
        
        case deleteButtonTapped(String)
        case alert(PresentationAction<Alert>)
        
        public enum Alert: Equatable, Sendable {
            case confirmDelete
        }
    }

    init() {}
    
    private enum CancelID {
        case visibleLists
        case availablePresets
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
                    }.cancellable(id: CancelID.visibleLists),
                    .run { send in
                        for try await presets in client.observeAvailablePresets() {
                            await send(.availablePresetsResponse(presets))
                        }
                    }.cancellable(id: CancelID.availablePresets)
                )
            case .onDisappear:
                return .merge(
                    .cancel(id: CancelID.visibleLists),
                    .cancel(id: CancelID.availablePresets)
                )
            case .visibleListsResponse(let lists):
                state.lists = lists
                return .none
            case .availablePresetsResponse(let presets):
                state.availablePresets = presets
                return .none
            case let .move(source, destination):

                state.lists.move(
                    fromOffsets: source,
                    toOffset: destination
                )

                let ids = state.lists.map(\.id)

                return .run { _ in
                    try await client.reorder(ids)
                }
            case let .restorePresetTapped(id):
                return .run { _ in
                    try await client.restorePreset(id)
                }
            case let .deleteButtonTapped(id):
                guard let list = state.lists.first(where: { $0.id == id}) else {
                    return .none
                }
                state.deletingList = list

                state.alert = .deleteConfirmation

                return .none
            case .closeButtonTapped:
                let dismiss = dismiss
                return .run { _ in
                    await dismiss()
                }
            case .alert(.presented(.confirmDelete)):
                guard let model = state.deletingList else {
                    return .none
                }

                state.deletingList = nil

                return .run { _ in
                    try await client.delete(model)
                }
            case .alert(_):
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

extension AlertState where Action == ReorderListsFeature.Action.Alert {
    static let deleteConfirmation = AlertState(
        title: {
            TextState("Delete list?")
        },
        actions: {
            ButtonState(role: .destructive, action: .confirmDelete) {
                TextState("Delete")
            }

            ButtonState(role: .cancel) {
                TextState("Cancel")
            }
        },
        message: {
            TextState("This action cannot be undone.")
        }
    )
}
