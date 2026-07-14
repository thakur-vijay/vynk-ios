//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import ComposableArchitecture
import VynkDesignSystem

@Reducer
public struct ContactDetailsFeature {
    
    @ObservableState
    public struct State: Equatable {
        
    }
    
    public enum Action {
        case rowTapped(ContactDetailsFeature.RowID)
    }
    
    public enum RowID {
        case contactDetails
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

public extension ContactDetailsFeature.State {
    
    var section: SectionModel<ContactDetailsFeature.RowID>{
        .init(
            rows: [
                .init(
                    id: .contactDetails,
                    title: "Contact details",
                    symbol: AppSymbols.personCircle.name,
                )
            ]
        )
    }
}

