//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 13/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct SharedMediaFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var mediaCount: Int = 2
        public var storage: String = "3 MB"
        public var starred: String = "None"
        public init(){
            
        }
    }
    
    public enum Action {
        case rowTapped(SharedMediaFeature.RowID)
    }
    
    public enum RowID: Hashable {
        case media
        case storage
        case starred
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .rowTapped(_):
                return .none
            }
        }
    }
}

public extension SharedMediaFeature.State {
    
    var section: SectionModel<SharedMediaFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .media,
                    title: "Media, links and docs",
                    symbol: AppSymbols.photo.name,
                    trailingText: mediaCount.description,
                ),
                .init(
                    id: .storage,
                    title: "Manage storage",
                    symbol: AppSymbols.storage.name,
                    trailingText: storage,
                ),
                .init(
                    id: .starred,
                    title: "Starred",
                    symbol: AppSymbols.star.name,
                    trailingText: starred,
                )
            ]
        )
    }
}

