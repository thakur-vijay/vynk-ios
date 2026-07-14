//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct ChatCustomizationFeature {
    
    @ObservableState
    public struct State: Equatable {
        
    }
    
    public enum Action {
        case rowTapped(ChatCustomizationFeature.RowID)
    }
    
    public enum RowID {
        case notifications
        case chatTheme
        case saveToPhotos
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

public extension ChatCustomizationFeature.State {
    
    var section: SectionModel<ChatCustomizationFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .notifications,
                    title: "Notifications",
                    symbol: AppSymbols.bell.name,
                ),
                .init(
                    id: .chatTheme,
                    title: "Chat theme",
                    symbol: AppSymbols.palette.name,
                ),
                .init(
                    id: .saveToPhotos,
                    title: "Save to Photos",
                    symbol: AppSymbols.download.name,
                )
            ]
        )
    }
}
