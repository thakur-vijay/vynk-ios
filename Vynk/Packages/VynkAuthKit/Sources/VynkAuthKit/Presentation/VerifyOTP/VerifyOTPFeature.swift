//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//

import ComposableArchitecture
import VynkCountryPicker

@Reducer
struct VerifyOTPFeature {
    
    @ObservableState
    struct State: Equatable{
        var country: CountryModel?
        var phoneNumber: String
        var otp: String = ""
        
        init(country: CountryModel? = nil, phoneNumber: String) {
            self.country = country
            self.phoneNumber = phoneNumber
        }
    }
    
    enum Action: BindableAction{
        case binding(BindingAction<State>)
        case didNotReceiveCodeTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding: return .none
            case .didNotReceiveCodeTapped: return .none
                
            }
        }
    }
}
