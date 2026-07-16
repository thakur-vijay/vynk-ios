//
//  SwiftUIView.swift
//  VynkSettingsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import ComposableArchitecture
import VynkChatLists

@Reducer
public struct SettingsFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var path = StackState<Path.State>()
        public var header = UserHeaderFeature.State()
        public var general = GeneralSectionFeature.State()
        public var preferences = PreferencesSectionFeature.State()
        public var support = SupportSectionFeature.State()
        public init(){
            
        }
        
        public var prefersTabBarHidden: Bool {
            switch path.last {
            case .lists: return true
            default: return false
            }
        }
    }
    
    public enum Action {
        case path(StackActionOf<Path>)
        case header(UserHeaderFeature.Action)
        case general(GeneralSectionFeature.Action)
        case preferences(PreferencesSectionFeature.Action)
        case support(SupportSectionFeature.Action)
        case logoutTapped
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        Scope(\.header, action: \.header) {
            UserHeaderFeature()
        }
        Scope(\.general, action: \.general) {
            GeneralSectionFeature()
        }
        Scope(\.preferences, action: \.preferences) {
            PreferencesSectionFeature()
        }
        Scope(\.support, action: \.support) {
            SupportSectionFeature()
        }
        Reduce { state, action in
            switch action {
            case .header:
                return .none
            case .general(.rowTapped(.lists)):
                state.path.append(.lists(ListsFeature.State()))
                return .none
            case .general:
                return .none
            case .preferences(_):
                return .none
            case .support(_):
                return .none
            case .logoutTapped:
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension SettingsFeature {
    
    @Reducer
    public enum Path {
        case lists(ListsFeature)
    }
}

extension SettingsFeature.Path.State: Equatable {
    
}
