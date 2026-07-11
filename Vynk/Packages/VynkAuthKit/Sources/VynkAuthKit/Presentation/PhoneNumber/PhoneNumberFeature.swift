//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import ComposableArchitecture
import VynkCountryPicker
import VynkFoundation

@Reducer
public struct PhoneNumberFeature {
    
    @Dependency(\.countryPickerClient)
    private var countryClient
    
    @ObservableState
    public struct State: Equatable {

        public var selectedCountry: CountryModel?
        public var phoneNumber: String = ""

        @Presents
        public var destination: PhoneNumberDestination.State?

        public init(
            selectedCountry: CountryModel? = nil
        ) {
            self.selectedCountry = selectedCountry
        }
    }
    
    public enum Action: BindableAction{
        case binding(BindingAction<State>)
        case onTask
        case currentCountryLoaded(CountryModel?)
        case countryPickerTapped
        case destination(PresentationAction<PhoneNumberDestination.Action>)
        case nextButtonTapped
        case delegate(Delegate)

        public enum Delegate {
            case continueWithPhone(
                country: CountryModel,
                phoneNumber: String
            )
        }
    }
    
    init(){
        
    }
    
    public  var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            let client = countryClient
            switch action {
            case .onTask:
                return .run { send in
                    let currentCountry = try client.fetchCurrentCountry()
                    await send(.currentCountryLoaded(currentCountry))
                }
            case .currentCountryLoaded(let country):
                state.selectedCountry = country
                return .none
            case .countryPickerTapped:
                state.destination = .countryPicker(
                    CountryPickerFeature.State(selectedCountry: state.selectedCountry)
                )
                return .none
            case .destination(.presented(.countryPicker(.delegate(.didSelectCountry(let selectedCountry))))):
                state.selectedCountry = selectedCountry
                state.destination = nil
                return .none
            case .destination(
                .presented(
                    .countryPicker(
                        .delegate(.didClose)
                    )
                )
            ):
                state.destination = nil
                return .none
            case .destination: return .none
            case .binding:
                state.phoneNumber.removeAll { !$0.isNumber}
                return .none
            case .nextButtonTapped:
                guard let country = state.selectedCountry else {
                    return .none
                }

                return .send(
                    .delegate(
                        .continueWithPhone(
                            country: country,
                            phoneNumber: state.phoneNumber
                        )
                    )
                )
            case .delegate(_):
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination){
            PhoneNumberDestination()
        }
    }
}

extension PhoneNumberFeature.State {
    
    var isActionEnabled: Bool {
        phoneNumber.isNotBlank
    }
}
