//
//  SwiftUIView.swift
//  VynkUserProfileKit
//
//  Created by Vijay Thakur on 14/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem


public struct ChatPrivacyView: View {
    @Bindable var store: StoreOf<ChatPrivacyFeature>
    
    public init(store: StoreOf<ChatPrivacyFeature>) {
        self.store = store
    }
    
    
    public var body: some View {
        SectionView(section: store.section, binding: binding(for:)) { rowID, _ in
            store.send(.rowTapped(rowID))
        }
    }
}

extension ChatPrivacyView {

    func binding(for rowID: ChatPrivacyFeature.RowID) -> Binding<Bool>? {
        switch rowID {
        case .lockChat:
            return $store.isChatLocked

        default:
            return nil
        }
    }
}
