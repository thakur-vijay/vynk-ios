//
//  AddContactView.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import SwiftUI
import VynkCountryPicker

struct AddContactView: View {
    @State private var viewModel: AddContactViewModel
    private let diContainer: AddContactDIContainer
    let onClose: ()->()
    init(
        viewModel: AddContactViewModel,
        diContainer: AddContactDIContainer,
        onClose: @escaping ()->()
    ) {
        _viewModel = State(wrappedValue: viewModel)
        self.diContainer = diContainer
        self.onClose = onClose
    }
    
    @Environment(\.appDIContainer) private var appDIContainer
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("First name", text: $viewModel.firstName)
                        .focused($focusedField, equals: .firstName)
                        .submitLabel(.next)
                        .onSubmit {
                            performWithoutAnimation{
                                focusedField = .lastName
                            }
                        }

                    TextField("Last name", text: $viewModel.lastName)
                        .focused($focusedField, equals: .lastName)
                        .submitLabel(.next)
                        .onSubmit {
                            performWithoutAnimation {
                                focusedField = .phone
                            }
                        }
                }
                
                Section {
                    Button {
                        viewModel.isCountryPickerPresented.toggle()
                    } label: {
                        HStack {
                            Text("Phone")
                                .font(AppFont.bodySemibold)
                                .foregroundStyle(AppColors.contentDefault)
                                .fillWidth(.leading)
                                .frame(width: 100)
                            
                            Text(viewModel.selectedCountry?.name ?? "")
                                .fillWidth(.leading)
                            
                            AppSymbols.rightChevron.image
                                .font(AppFont.caption)
                            
                                .foregroundStyle(AppColors.contentDeemphasized)
                            
                        }
                    }
                    .tint(.primary)
                    .alignmentGuide(.listRowSeparatorLeading) { dimensions in
                        100
                    }

                    
                    HStack {
                        Text("Mobile")
                            .font(AppFont.bodySemibold)
                            .foregroundStyle(AppColors.contentDefault)
                            .fillWidth(.leading)
                            .frame(width: 100)
                        HStack {
                            Text(viewModel.selectedCountry?.dialCode ?? "")
                            TextField("Phone", text: $viewModel.phone)
                                .focused($focusedField, equals: .phone)
                                .keyboardType(.numberPad)
                                .textContentType(.telephoneNumber)
                        }
                    }

                }
                
                Section {
                    Toggle("Sync contact to phone", isOn: .init(get: {
                        return viewModel.syncContactToPhone
                    }, set: { newValue in
                        viewModel.handleSyncToPhone(newValue: newValue)
                    }))
                }
                
                Section {
                    HStack {
                        AppSymbols.qrcode.image
                            .font(AppFont.title1)
                        Text("Add via QR code")
                    }
                    .fillWidth()
                    .foregroundStyle(AppColors.accentSoft)
                    .listRowBackground(EmptyView())
                    .listRowInsets(.top, 0)
                }

            }
            .navigationTitle("New contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarCloseButton(placement: .topBarLeading) {
                    focusedField = nil
                    if viewModel.phone.isNotBlank {
                        viewModel.presentDiscardConfirmationDialog(onClose: onClose)
                    }else {
                        onClose()
                    }
                }
                
                CheckButton(isEnabled: viewModel.isSaveEnabled) {
                    Task {
                        await viewModel.addContact()
                    }
                }
                
            }
            .animation(.snappy(duration: 0.25), value: viewModel.isSaveEnabled)
            .sheet(isPresented: $viewModel.isCountryPickerPresented) {
                diContainer.makeCountryPickerView(
                    selectedCountry: viewModel.selectedCountry
                ) { selectedCountry in
                    viewModel.selectedCountry = selectedCountry
                    viewModel.isCountryPickerPresented.toggle()
                }
            }
        }
        .appConfirmationDialog($viewModel.confirmationDialogConfig)
        .appAlert($viewModel.alertConfig)
        .task {
            await viewModel.prepareSyncToPhone()
        }

    }
    
    private enum Field {

        case firstName

        case lastName

        case phone

    }
}
