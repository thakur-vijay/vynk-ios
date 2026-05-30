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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
