//
//  SwiftUIView.swift
//  VynkQRCodeKit
//
//  Created by Vijay Thakur on 18/07/26.
//

import ComposableArchitecture
import SwiftUI

@Reducer
public struct ProfileQRCodeFeature {
    @ObservableState
    public struct State: Equatable {
        public var qrContent: String = "https://www.apple.com"
        public init(){
            
        }
    }
    
    public enum Action {
        case resetQRCodeTapped
        case shareTapped
        case scanTapped
    }
    
    public init(){
        
    }
    
    private enum CancelID {
        case brightness
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .resetQRCodeTapped:
                return .none
            case .shareTapped:
                return .none
            case .scanTapped:
                return .none
            }
        }
    }
}
