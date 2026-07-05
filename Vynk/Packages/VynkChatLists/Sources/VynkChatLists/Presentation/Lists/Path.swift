//
//  Path.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 05/07/26.
//


import ComposableArchitecture

@Reducer
public struct Path {

    @ObservableState
    public enum State: Equatable {

    }

    public enum Action {

    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            .none
        }
    }
}