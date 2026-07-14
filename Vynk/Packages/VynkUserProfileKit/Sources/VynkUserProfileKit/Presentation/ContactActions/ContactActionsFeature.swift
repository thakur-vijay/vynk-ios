//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct ContactActionsFeature {
    
    @ObservableState
    public struct State: Equatable {
        
    }
    
    public enum Action {
        case rowTapped(ContactActionsFeature.RowID)
    }
    
    public enum RowID {
        case shareContact
        case addToFavourites
        case addToList
        case exportChat
        case clearChat
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .rowTapped(let rowID):
                return .none
            }
        }
    }
}

public extension ContactActionsFeature.State {
    
    var section: SectionModel<ContactActionsFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .shareContact,
                    title: "Share contact",
                    kind: .action(style: .accent)
                ),
                .init(
                    id: .addToFavourites,
                    title: "Add to Favourites",
                    kind: .action(style: .accent)
                ),
                .init(
                    id: .addToList,
                    title: "Add to list",
                    kind: .action(style: .accent)
                ),
                .init(
                    id: .exportChat,
                    title: "Export chat",
                    kind: .action(style: .accent)
                ),
                .init(
                    id: .clearChat,
                    title: "Clear chat",
                    kind: .destructive
                ),
            ]
        )
    }
}

