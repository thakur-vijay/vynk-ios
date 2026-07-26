//
//  SwiftUIView.swift
//  VynkQRCodeKit
//
//  Created by Vijay Thakur on 18/07/26.
//

import ComposableArchitecture
import SwiftUI
import VynkScannerKit

@Reducer
public struct ProfileQRCodeFeature {

    @ObservableState
    public struct State: Equatable {
        public var qrContent: String = "https://www.apple.com"

        @Presents
        public var destination: Destination.State?

        public init() {}
    }

    public enum Action {
        case resetQRCodeTapped
        case shareTapped
        case scanTapped

        case destination(PresentationAction<Destination.Action>)
        case delegate(Delegate)
        
        public enum Delegate {
            case openChat
        }
    }

    @Reducer
    public enum Destination {
        case scanner(ScannerFeature)
    }

    public init() {}

    public var body: some ReducerOf<Self> {

        Reduce { state, action in
            switch action {

            case .resetQRCodeTapped:
                return .none

            case .shareTapped:
                return .none

            case .scanTapped:
                state.destination = .scanner(
                    ScannerFeature.State()
                )
                return .none

            case let .destination(.presented(.scanner(.delegate(delegate)))):
                switch delegate {

                case let .scannerResult(result):
                    state.destination = nil
                    switch result {
                    case .qrCode(let qr):
                        state.qrContent = qr
                        return .send(.delegate(.openChat))
                    @unknown default:
                        return .none
                    }
                case .dismiss:
                    state.destination = nil
                    return .none
                }
            case .destination:
                return .none
            case .delegate:
                return .none
            }
        }
        .ifLet(
            \.$destination,
            action: \.destination
        )
    }
}

extension ProfileQRCodeFeature.Destination.State: Equatable {
    
}
