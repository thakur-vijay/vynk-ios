//
//  StatusesFeature.swift
//  VynkStatusKit
//
//  Created by Vijay Thakur on 15/07/26.
//


import ComposableArchitecture
import Foundation

@Reducer
public struct StatusesFeature {

    @ObservableState
    public struct State: Equatable {

        public var currentUserStatus: StatusCardModel = .init(
            id: "me",
            user: .init(
                id: "me",
                name: "Vijay Thakur",
                avatarURL: "https://images.pexels.com/photos/13473569/pexels-photo-13473569.jpeg"
            ),
            statuses: [],
            isCurrentUser: true
        )

        public var statuses: IdentifiedArrayOf<StatusCardModel> = .init(
            uniqueElements: (1...10).map { index in
                StatusCardModel(
                    id: "\(index)",
                    user: .init(
                        id: UUID().uuidString,
                        name: "Test \(index)",
                        avatarURL: "https://images.pexels.com/photos/13473569/pexels-photo-13473569.jpeg"
                    ),
                    statuses: [
                        .init(
                            id: UUID().uuidString,
                            mediaURL: "https://images.pexels.com/photos/13473569/pexels-photo-13473569.jpeg",
                            type: .image,
                            createdAt: .now
                        )
                    ],
                    isCurrentUser: false
                )
            }
        )

        public var isLoading = false

        public init(
//            currentUserStatus: StatusCardModel? = nil,
//            statuses: IdentifiedArrayOf<StatusCardModel> = [],
            isLoading: Bool = false
        ) {
//            self.currentUserStatus = currentUserStatus
//            self.statuses = statuses
            self.isLoading = isLoading
        }
    }

    public enum Action: BindableAction {

        case binding(BindingAction<State>)

        case onAppear

        case cameraTapped
        case pencilTapped

        case currentUserStatusTapped
        case statusTapped(id: StatusCardModel.ID)

        case delegate(Delegate)

        public enum Delegate: Equatable {

            case createStatus
            case openCamera
            case openStatusViewer(id: StatusCardModel.ID)

        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {

        BindingReducer()

        Reduce { state, action in

            switch action {

            case .binding:
                return .none

            case .onAppear:
                return .none

            case .cameraTapped:
                return .send(.delegate(.openCamera))

            case .pencilTapped:
                return .send(.delegate(.createStatus))

            case .currentUserStatusTapped:
                if state.currentUserStatus.hasStatus {
                    return .send(.delegate(.openStatusViewer(id: state.currentUserStatus.id)))
                } else {
                    return .send(.delegate(.createStatus))
                }

            case let .statusTapped(id):
                return .send(.delegate(.openStatusViewer(id: id)))

            case .delegate:
                return .none
            }
        }
    }
}
