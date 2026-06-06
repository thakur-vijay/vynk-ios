//
//  ContactsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct ContactsView: View {
    @State private var viewModel: ContactsViewModel
    private let onInviteTap: (DeviceContact)->()
    init(viewModel: ContactsViewModel, onInviteTap: @escaping (DeviceContact)->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.onInviteTap = onInviteTap
    }
    
    var body: some View {
        Group {
            FrequentlyContactedSection(contacts: MockDataFactory.makeVynkContacts(count: 5))
                .listSectionSpacing(.custom(10))
            ContactsOnVynkSection(contacts: [
                VynkContactModel(avatar: MockImages.avatar, name: "Contact 8146408409 (You)", about: "Message yourself")
            ])
            .listSectionSpacing(.custom(10))
            
            VynkContactsGroupSection(sections: viewModel.contactsOnVynkSections)
                .listSectionSpacing(.custom(10))
            
            //            if viewModel.status != .authorized {
            ContactPermissionText()
                .listSectionSpacing(.custom(10))
            
            //            }
            if viewModel.contacts.count > 0 {
                InviteToVynkSection(contacts: viewModel.contacts, onInviteTap: onInviteTap)
                    .listSectionSpacing(.custom(10))
                
            }
        }
        .task {
            viewModel.fetchVynkContacts()
            await viewModel.fetchContacts()
        }
    }
}
