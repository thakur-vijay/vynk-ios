//
//  NewChatDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI

final class NewChatDIContainer {

    private let addContactDIContainer: AddContactDIContainer

    private let contactsDIContainer: ContactsDIContainer
    
    private let inviteDIContainer: InviteDIContainer

    init(

        addContactDIContainer: AddContactDIContainer,

        contactsDIContainer: ContactsDIContainer,
        
        inviteDIContaier: InviteDIContainer

    ) {

        self.addContactDIContainer = addContactDIContainer

        self.contactsDIContainer = contactsDIContainer
        
        self.inviteDIContainer = inviteDIContaier

    }

    func makeAddContactView() -> AddContactView {

        addContactDIContainer.makeAddContactView()

    }

    func makeContactsView(onInviteTap: @escaping (DeviceContact)->()) -> ContactsView {

        contactsDIContainer.makeContactsView(onInviteTap: onInviteTap)

    }
    
    func makeInviteView(phone: DeviceContact, onFinish: @escaping ()->Void)-> MessageComposeView {
        inviteDIContainer.makeMessageComposeView(phoneNumber: phone.phoneNumbers.first, onFinish: onFinish)
    }

}
