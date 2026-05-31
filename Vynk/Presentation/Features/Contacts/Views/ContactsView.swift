//
//  ContactsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct ContactsView: View {
    @State private var viewModel: ContactsViewModel
    
    init(viewModel: ContactsViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            FrequentlyContactedSection(contacts: MockDataFactory.makeVynkContacts(count: 5))
            ContactsOnVynkSection(contacts: [
                VynkContactModel(avatar: MockImages.avatar, name: "Contact 8146408409 (You)", about: "Message yourself")
            ])
            VynkContactsGroupSection(sections: viewModel.contactsOnVynkSections)
            InviteToVynkSection(contacts: viewModel.contacts)
        }
        .task {
            viewModel.fetchVynkContacts()
            await viewModel.fetchContacts()
        }
    }
}
