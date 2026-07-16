//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 17/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct SupportSectionFeature {
    
    @ObservableState
    public struct State: Equatable {
        
    }
    
    public enum Action {
        case rowTapped(SupportSectionFeature.RowID)
    }
    
    public enum RowID {
        case helpAndFeedback
        case inviteAFriend
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

public extension SupportSectionFeature.State {
    
    var section: SectionModel<SupportSectionFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .helpAndFeedback,
                    title: "Help and feedback",
                    symbol: AppSymbols.questionmarkCircle.name
                ),
                .init(
                    id: .inviteAFriend,
                    title: "Invite a friend",
                    symbol: AppSymbols.heart.name
                )
            ]
        )
    }
}

