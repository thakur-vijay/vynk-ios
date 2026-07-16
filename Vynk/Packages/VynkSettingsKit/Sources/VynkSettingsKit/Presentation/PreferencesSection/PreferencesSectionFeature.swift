//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 17/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct PreferencesSectionFeature {
    
    @ObservableState
    public struct State: Equatable {
        
    }
    
    public enum Action {
        case rowTapped(PreferencesSectionFeature.RowID)
    }
    
    public enum RowID {
        case account
        case privacy
        case chats
        case notifications
        case payments
        case storageAndData
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

public extension PreferencesSectionFeature.State {
    
    var section: SectionModel<PreferencesSectionFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .account,
                    title: "Account",
                    symbol: AppSymbols.key.name
                ),
                .init(
                    id: .privacy,
                    title: "Privacy",
                    symbol: AppSymbols.lock.name
                ),
                .init(
                    id: .chats,
                    title: "Chats",
                    symbol: AppSymbols.message.name
                ),
                .init(
                    id: .notifications,
                    title: "Notifications",
                    symbol: AppSymbols.appBadge.name
                ),
                .init(
                    id: .payments,
                    title: "Payments",
                    symbol: AppSymbols.rupee.name
                ),
                .init(
                    id: .storageAndData,
                    title: "Storage and data",
                    symbol: AppSymbols.storage.name
                ),
            ]
        )
    }
}

