//
//  ChatsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

final class ChatsDIContainer {
    private let contactsDIContainer: ContactsDIContainer
    private let addContactDIContainer: AddContactDIContainer
    private let inviteDIContainer: InviteDIContainer
    private let cameraDIContainer: CameraDIContainer
    private let chatListsDIContainer: ChatListsDIContainer
    private let appPreferences: AppPreferencesManaging
    private let appRouter: AppRouter
    
    init(
        contactsDIContainer: ContactsDIContainer,
        addContactDIContainer: AddContactDIContainer,
        inviteDIContainer: InviteDIContainer,
        cameraDIContainer: CameraDIContainer,
        chatListsDIContainer: ChatListsDIContainer,
        appPreferences: AppPreferencesManaging,
        appRouter: AppRouter
    ) {
        self.contactsDIContainer = contactsDIContainer
        self.addContactDIContainer = addContactDIContainer
        self.inviteDIContainer = inviteDIContainer
        self.cameraDIContainer = cameraDIContainer
        self.chatListsDIContainer = chatListsDIContainer
        self.appPreferences = appPreferences
        self.appRouter = appRouter
    }

    func makeChatsView() -> ChatsView {

        let viewModel = ChatsViewModel(
            contactsPermissionUseCase: contactsDIContainer.makeContactsPermissionUseCase(),
            observeVisibleListsUseCase: chatListsDIContainer.observeVisibleListsUseCase,
            deleteChatListUseCase: chatListsDIContainer.deleteChatListUseCase,
            appPreferences: appPreferences
        )

        return ChatsView(
            viewModel: viewModel,
            router: appRouter.chatsRouter,
            appRouter: appRouter
        )

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
    
    func makeCameraFullScreenCover(onClose: @escaping ()->())-> CameraView {
        return cameraDIContainer.makeView(onClose: onClose)
    }

    lazy var newChatDIContainer: NewChatDIContainer = {
        NewChatDIContainer(
            addContactDIContainer: addContactDIContainer,
            contactsDIContainer: contactsDIContainer,
            inviteDIContaier: inviteDIContainer
        )
    }()
    
    func makeReorderListSheet() -> ReorderListsView {
        return chatListsDIContainer.makeReorderListSheet()
    }
    
    func makeListEditor(mode: ListEditorMode, completion: @escaping ()->())-> ListEditor {
        return chatListsDIContainer.makeListEditor(mode: mode, completion: completion)
    }
}
