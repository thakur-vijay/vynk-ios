//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 16/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct GeneralSectionFeature {
    
    @ObservableState
    public struct State: Equatable {
        
    }
    
    public enum Action {
        case rowTapped(GeneralSectionFeature.RowID)
    }
    
    public enum RowID {
        case lists
        case broadcastMessages
        case starred
        case linkedDevices
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

public extension GeneralSectionFeature.State {
    
    var section: SectionModel<GeneralSectionFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .lists,
                    title: "Lists",
                    symbol: AppSymbols.ChatAction.addToListMenu.name
                ),
                .init(
                    id: .broadcastMessages,
                    title: "Broadcast messages",
                    symbol: AppSymbols.broadcast.name
                ),
                .init(
                    id: .starred,
                    title: "Starred",
                    symbol: AppSymbols.star.name
                ),
                .init(
                    id: .linkedDevices,
                    title: "Linked devices",
                    symbol: AppSymbols.laptop.name
                ),
            ]
        )
    }
}

