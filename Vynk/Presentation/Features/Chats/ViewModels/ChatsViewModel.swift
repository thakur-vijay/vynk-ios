//
//  ChatsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

@MainActor
@Observable
final class ChatsViewModel {
    var searchText: String = ""
    var isSearchPresented: Bool = false
    var chats: [MessageThreadRowModel] = MockDataFactory.chats
    var isPermissionStatusCardHidden: Bool = false
    
    var router: ChatsRouter
    private let contactsPermissionUseCase: ContactsPermissionUseCase
    private let appPreferences: AppPreferences
    
    
    init(
        router: ChatsRouter,
        contactsPermissionUseCase: ContactsPermissionUseCase,
        appPreferences: AppPreferences
    ) {
        self.router = router
        self.contactsPermissionUseCase = contactsPermissionUseCase
        self.appPreferences = appPreferences
    }
    
    func openChat(_ model: MessageThreadRowModel){
        router.push(.detail(model))
    }
    
    func openUserDetail(){
        router.push(.userDetail)
    }
    
    func handlePermissionStatusCard(){
        let permissionStatus = contactsPermissionUseCase.status()
        let isCardAlreadyShownAndDismissed = appPreferences.isContactsPermissionStatusCardHidden
        AppLogger.info(permissionStatus, tag: String(describing: self))
        AppLogger.info(isCardAlreadyShownAndDismissed, tag: String(describing: self))
        isPermissionStatusCardHidden = permissionStatus == .authorized || permissionStatus == .notDetermined || isCardAlreadyShownAndDismissed
    }
    
    func hidePermissionStatusCard(){
        appPreferences.isContactsPermissionStatusCardHidden = true
        isPermissionStatusCardHidden = true
    }
}
