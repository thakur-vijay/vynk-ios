//
//  File.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 05/07/26.
//

import Foundation
import ComposableArchitecture

@Reducer
internal struct Destination {

    @ObservableState
    enum State: Equatable {
        case listEditor(ListEditorFeature.State)
        case reorderLists(ReorderListsFeature.State)
    }

    enum Action {
        case listEditor(ListEditorFeature.Action)
        case reorderLists(ReorderListsFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {

        Reduce { state, action in
            .none
        }
        .ifCaseLet(\.listEditor, action: \.listEditor) {
            ListEditorFeature()
        }
        .ifCaseLet(\.reorderLists, action: \.reorderLists) {
            ReorderListsFeature()
        }
    }
}
