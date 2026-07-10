//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 09/07/26.
//

import ComposableArchitecture

@Reducer
struct PhoneNumberFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents
        var destination: Destination.State?
        
        init() {
            
        }
    }
    
    enum Action {
        
    }
    
    init(){
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
                .none
        }
    }
}
