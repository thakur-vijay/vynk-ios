//
//  ChatsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class ChatsViewModel {
    var searchText: String = ""
    var isSearchPresented: Bool = false
    var chats: [MessageThreadRowModel] = MockDataFactory.chats
    var isPermissionStatusCardHidden: Bool = false
    var lists: [ChatListRowModel] = []
    var alertConfig: DialogConfig?
    private var observeListsTask: Task<Void, Never>?

    
    private let contactsPermissionUseCase: ContactsPermissionUseCase
    private let observeVisibleListsUseCase: ObserveVisibleListsUseCase
    private let deleteChatListUseCase: DeleteChatListUseCase
    private let appPreferences: AppPreferences
    
    
    init(
        contactsPermissionUseCase: ContactsPermissionUseCase,
        observeVisibleListsUseCase: ObserveVisibleListsUseCase,
        deleteChatListUseCase: DeleteChatListUseCase,
        appPreferences: AppPreferences
    ) {
        self.contactsPermissionUseCase = contactsPermissionUseCase
        self.observeVisibleListsUseCase = observeVisibleListsUseCase
        self.deleteChatListUseCase = deleteChatListUseCase
        self.appPreferences = appPreferences
    }
    
    func handlePermissionStatusCard()async{
        let permissionStatus = await contactsPermissionUseCase.status()
        let isCardAlreadyShownAndDismissed = appPreferences.isContactsPermissionStatusCardHidden
        AppLogger.info(permissionStatus, tag: String(describing: self))
        AppLogger.info(isCardAlreadyShownAndDismissed, tag: String(describing: self))
        isPermissionStatusCardHidden = permissionStatus == .authorized || permissionStatus == .notDetermined || isCardAlreadyShownAndDismissed
    }
    
    func hidePermissionStatusCard(){
        appPreferences.isContactsPermissionStatusCardHidden = true
        isPermissionStatusCardHidden = true
    }
    
    func startObserving() {
        observeListsTask?.cancel()
        
        observeListsTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                for try await result in observeVisibleListsUseCase.execute() {
                    lists = result.map {
                        ChatListMapper.map($0)
                    }
                }
            } catch {
                AppLogger.error(error.localizedDescription, tag: String(describing: self))
            }
        }
    }
    
    func stopObserving() {
        observeListsTask?.cancel()
        observeListsTask = nil
    }
    
    func presentDeleteAlert(for list: ChatListRowModel) {
        alertConfig = ChatListAlertFactory.makeDeleteAlert(
            for: list,
            onDelete: {[weak self] in
                guard let self else { return }
                Task {
                    await self.deleteList(model: list)
                }
        })
    }
    
    func deleteList(model: ChatListRowModel) async{
        do {
            try await deleteChatListUseCase.execute(list: model)
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
}
