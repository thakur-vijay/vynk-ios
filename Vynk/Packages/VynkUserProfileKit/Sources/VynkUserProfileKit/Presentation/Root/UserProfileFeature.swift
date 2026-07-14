//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 12/07/26.
//

import ComposableArchitecture

@Reducer
public struct UserProfileFeature {
    
    @ObservableState
    public struct State: Equatable {
        public var header = UserProfileHeaderFeature.State()
        public var quickActions = UserQuickActionsFeature.State()
        public var sharedMedia = SharedMediaFeature.State()
        public var chatCustomization = ChatCustomizationFeature.State()
        public var chatPrivacy = ChatPrivacyFeature.State()
        public var contactDetails = ContactDetailsFeature.State()
        public var contactActions = ContactActionsFeature.State()
        public var safety: SafetyFeature.State
        public init(){
            safety = SafetyFeature.State(userName: "Vijay Thakur")
        }
    }
    
    public enum Action {
        case header(UserProfileHeaderFeature.Action)
        case quickActions(UserQuickActionsFeature.Action)
        case sharedMedia(SharedMediaFeature.Action)
        case chatCustomization(ChatCustomizationFeature.Action)
        case chatPrivacy(ChatPrivacyFeature.Action)
        case contactDetails(ContactDetailsFeature.Action)
        case contactActions(ContactActionsFeature.Action)
        case safety(SafetyFeature.Action)
    }
    
    public init(){
        
    }
    
    public var body: some ReducerOf<Self> {
        Scope(\.header, action: \.header) {
            UserProfileHeaderFeature()
        }
        
        Scope(\.quickActions, action: \.quickActions) {
            UserQuickActionsFeature()
        }
        
        Scope(\.sharedMedia, action: \.sharedMedia) {
            SharedMediaFeature()
        }
        
        Scope(\.chatCustomization, action: \.chatCustomization) {
            ChatCustomizationFeature()
        }
        
        Scope(\.chatPrivacy, action: \.chatPrivacy) {
            ChatPrivacyFeature()
        }
        
        Scope(\.contactDetails, action: \.contactDetails) {
            ContactDetailsFeature()
        }
        
        Scope(\.contactActions, action: \.contactActions) {
            ContactActionsFeature()
        }
        
        Scope(\.safety, action: \.safety) {
            SafetyFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
