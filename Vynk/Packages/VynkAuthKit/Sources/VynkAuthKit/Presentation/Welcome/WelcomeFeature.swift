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
    struct State: Equatable{
        var path = StackState<Path.State>()
        init(){
            
        }
    }
    
    enum Action {
        case continueButtonTapped
        case linkTapped(String)
        case path(StackActionOf<Path>)
    }
    
    init() {
        
    }
    
    @Reducer
    enum Path {
        case phoneNumber(PhoneNumberFeature)
        case verifyOPT(VerifyOTPFeature)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .continueButtonTapped:
                state.path.append(.phoneNumber(PhoneNumberFeature.State()))
                print(state.path)
                return .none
                
            case .linkTapped(let link):
                print(link)
                return .none
            case .path(.element(_, action: .phoneNumber(.delegate(.continueWithPhone(let country, let phoneNumber))))):
                state.path.append(
                    .verifyOPT(
                        VerifyOTPFeature.State(
                            country: country,
                            phoneNumber: phoneNumber,
                        )
                    )
                )
                return .none
            case .path: return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension WelcomeFeature.Path.State: Equatable {}
