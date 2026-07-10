//
//  File.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import ComposableArchitecture

@Reducer
struct WelcomeFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents
        var destination: Destination.State?
        
        var path = StackState<Path.State>()
        init(){
            
        }
    }
    
    enum Action {
        case continueButtonTapped
        case linkTapped(String)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    init() {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .continueButtonTapped:
                state.path.append(.phoneNumber(PhoneNumberFeature.State()))
                return .none
            case .linkTapped(let link):
                print(link)
                return .none
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
}
