//
//  ChatsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

final class ChatsDIContainer {
    private let contactsDIContainer: ContactsDIContainer
    
    init(contactsDIContainer: ContactsDIContainer) {
        self.contactsDIContainer = contactsDIContainer
    }

    func makeChatsView() -> ChatsView {

        let router = ChatsRouter()

        let viewModel = ChatsViewModel(router: router)

        return ChatsView(viewModel: viewModel)

    }

    

    func makeNewChatBottomSheet(
        onClose: @escaping () -> Void
    ) -> NewChatBottomSheet<some View> {
        NewChatBottomSheet(
            viewModel: .init(),
            content: contactsDIContainer.makeContactsView,
            onClose: onClose
        )
    }

}
