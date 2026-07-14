//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct ChatPrivacyFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var isChatLocked = false
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case rowTapped(RowID)
    }
    
    public enum RowID {
        case disappearingMessages
        case lockChat
        case advancedChatPrivacy
        case encryption
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .rowTapped:
                return .none
            }
        }
    }
}

public extension ChatPrivacyFeature.State {
    
    var section: SectionModel<ChatPrivacyFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .disappearingMessages,
                    title: "Disappearing messages",
                    symbol: AppSymbols.timer.name,
                    trailingText: "Off",
                ),
                .init(
                    id: .lockChat,
                    title: "Lock chat",
                    symbol: AppSymbols.lockOpen.name,
                    subtitle: "Lock and hide this chat on this device.",
                    kind: .toggle
                ),
                .init(
                    id: .advancedChatPrivacy,
                    title: "Advanced chat privacy",
                    symbol: AppSymbols.shield.name,
                    trailingText: "Off"
                ),
                .init(
                    id: .encryption,
                    title: "Encryption",
                    symbol: AppSymbols.lock.name,
                    subtitle: "Messages and calls are end-to-end encrypted. Tap to verify"
                )
            ]
        )
    }
}

