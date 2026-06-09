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
    
    private let contactsPermissionUseCase: ContactsPermissionUseCase
    private let appPreferences: AppPreferences
    
    
    init(
        contactsPermissionUseCase: ContactsPermissionUseCase,
        appPreferences: AppPreferences
    ) {
        self.contactsPermissionUseCase = contactsPermissionUseCase
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
}
