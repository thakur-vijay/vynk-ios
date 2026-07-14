//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct SafetyFeature {
    
    @ObservableState
    public struct State: Equatable {
        var userName: String = ""
        
        public init(userName: String) {
            self.userName = userName
        }
    }
    
    public enum Action {
        case rowTapped(SafetyFeature.RowID)
    }
    
    public enum RowID {
        case block
        case report
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

public extension SafetyFeature.State {
    
    var section: SectionModel<SafetyFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .block,
                    title: "Block \(userName)",
                    kind: .destructive
                ),
                .init(
                    id: .report,
                    title: "Report \(userName)",
                    kind: .destructive
                ),
            ]
        )
    }
}

