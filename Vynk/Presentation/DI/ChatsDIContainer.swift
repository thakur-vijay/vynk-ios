//
//  ChatsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

final class ChatsDIContainer {
    private let contactsDIContainer: ContactsDIContainer
    private let addContactDIContainer: AddContactDIContainer
    private let inviteDIContainer: InviteDIContainer
    
    init(
        contactsDIContainer: ContactsDIContainer,
        addContactDIContainer: AddContactDIContainer,
        inviteDIContainer: InviteDIContainer
    ) {
        self.contactsDIContainer = contactsDIContainer
        self.addContactDIContainer = addContactDIContainer
        self.inviteDIContainer = inviteDIContainer
    }

    func makeChatsView() -> ChatsView {

        let router = ChatsRouter()

        let viewModel = ChatsViewModel(router: router)

        return ChatsView(viewModel: viewModel)

    }

    

    func makeNewChatBottomSheet(
        onClose: @escaping () -> Void
    ) -> NewChatBottomSheet{
        NewChatBottomSheet(
            viewModel: .init(),
            router: .init(),
            diContainer: newChatDIContainer,
            onClose: onClose
        )
    }

    lazy var newChatDIContainer: NewChatDIContainer = {
        NewChatDIContainer(
            addContactDIContainer: addContactDIContainer,
            contactsDIContainer: contactsDIContainer,
            inviteDIContaier: inviteDIContainer
        )
    }()
}
