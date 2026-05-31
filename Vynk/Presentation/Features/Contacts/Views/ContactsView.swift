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
            FrequentlyContactedSection()
            ContactsOnVynkSection()
            InviteToVynkSection(contacts: viewModel.contacts)
        }
        .task {
            await viewModel.fetchContacts()
        }
    }
}
