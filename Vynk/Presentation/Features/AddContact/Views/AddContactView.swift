//
//  AddContactView.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import SwiftUI

struct AddContactView: View {
    @State private var viewModel: AddContactViewModel
    private let diContainer: AddContactDIContainer
    init(
        viewModel: AddContactViewModel,
        diContainer: AddContactDIContainer
    ) {
        _viewModel = State(wrappedValue: viewModel)
        self.diContainer = diContainer
    }
    
    @Environment(\.appDIContainer) private var appDIContainer
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("First name", text: $viewModel.firstName)

                    TextField("Last name", text: $viewModel.lastName)

                }

                
                Section {
                    Button {
                        viewModel.isCountryPickerPresented.toggle()
                    } label: {
                        HStack {
                            Text("Phone")
                                .font(AppFont.bodySemibold)
                                .foregroundStyle(AppColors.contentDefault)
                                .hSpacing(.leading)
                                .frame(width: 100)
                            
                            Text("India")
                                .hSpacing(.leading)
                            
                            Image(systemName: AppIcons.rightChevron)
                            
                                .font(AppFont.caption)
                            
                                .foregroundStyle(AppColors.contentDeemphasized)
                            
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { dimensions in
                        100
                    }

                    
                    HStack {
                        Text("Mobile")
                            .font(AppFont.bodySemibold)
                            .foregroundStyle(AppColors.contentDefault)
                            .hSpacing(.leading)
                            .frame(width: 100)
                        HStack {
                            Text("+91")
                            TextField("Phone", text: $viewModel.phone)
                        }
                    }

                }
                
                Section {
                    Toggle("Sync contact to phone", isOn: $viewModel.syncContactToPhone)
                }
                
                Section {
                    HStack {
                        Image(systemName: AppIcons.qrcode)
                            .font(AppFont.title1)
                        Text("Add via QR code")
                    }
                    .hSpacing()
                    .foregroundStyle(AppColors.accentSoft)
                    .listRowBackground(EmptyView())
                    .listRowInsets(.top, 0)
                }

            }
            .navigationTitle("New contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarCloseButton(placement: .topBarLeading) {
                    
                }
                
                ProminentToolbarButton(icon: AppIcons.checkmark) {
                    Task {
                        await viewModel.addContact()
                    }
                }
            }
            .sheet(isPresented: $viewModel.isCountryPickerPresented) {
                diContainer.makeCountryPickerView(
                    selectedCountry: viewModel.selectedCountry
                ) { selectedCountry in
                    viewModel.selectedCountry = selectedCountry
                    viewModel.isCountryPickerPresented.toggle()
                }
            }
        }
    }
}
