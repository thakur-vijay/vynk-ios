//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//

import ComposableArchitecture
import VynkCountryPicker

@Reducer
public struct VerifyOTPFeature {
    
    @ObservableState
    public struct State: Equatable{
        public var country: CountryModel?
        public var phoneNumber: String
        public var otp: String = ""
        
        public init(country: CountryModel? = nil, phoneNumber: String) {
            self.country = country
            self.phoneNumber = phoneNumber
        }
    }
    
    public enum Action: BindableAction{
        case binding(BindingAction<State>)
        case didNotReceiveCodeTapped
        case delegate(Delegate)

        public enum Delegate: Equatable {
            case loginSucceeded
        }
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding: return .none
            case .didNotReceiveCodeTapped: return .none
            case .delegate: return .none
            }
        }
    }
}
