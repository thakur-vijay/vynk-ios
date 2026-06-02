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

    init(

        addContactDIContainer: AddContactDIContainer,

        contactsDIContainer: ContactsDIContainer

    ) {

        self.addContactDIContainer = addContactDIContainer

        self.contactsDIContainer = contactsDIContainer

    }

    func makeAddContactView() -> AddContactView {

        addContactDIContainer.makeAddContactView()

    }

    func makeContactsView() -> ContactsView {

        contactsDIContainer.makeContactsView()

    }

}
