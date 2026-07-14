//
//  File.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 05/07/26.
//

import ComposableArchitecture

@Reducer
public struct ListEditorFeature {
    @Dependency(\.chatListsClient)
    private var client
    
    @Dependency(\.dismiss)
    private var dismiss
    
    @ObservableState
    public struct State: Equatable {

        public let mode: ListEditorMode

        public var title = ""

        public init(mode: ListEditorMode) {
            self.mode = mode
        }
    }
    
    public enum Action: BindableAction{
        case binding(BindingAction<State>)
        case saveButtonTapped
        case saveCompleted
        case closeButtonTapped
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self>{
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .saveButtonTapped:
                let client = client
                let title = state.title

                return .run { send in
                    try await client.save(title)
                    await send(.saveCompleted)
                }
            case .saveCompleted:
                let dismiss = dismiss

                return .run { _ in
                    await dismiss()
                }
            case .binding(_):
                return .none
            case .closeButtonTapped:
                let dismiss = dismiss
                return .run { _ in
                    await dismiss()
                }
            }
        }
    }
}

extension ListEditorFeature.State {

    var navigationTitle: String {

        switch mode {

        case .create:
            "New list"

        case .edit:
            "Edit list"
        }
    }

    var isSaveEnabled: Bool {

        title.isNotBlank
    }
}
