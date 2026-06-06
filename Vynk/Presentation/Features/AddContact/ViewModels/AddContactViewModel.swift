//
//  AddContactViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import Foundation

@MainActor
@Observable
final class AddContactViewModel {
    var firstName: String = ""
    var lastName: String = ""
    var phone: String = ""
    var syncContactToPhone: Bool
    var isCountryPickerPresented: Bool = false
    var isDiscardConfirmationDialogPresented: Bool = false
    var selectedCountry: CountryModel?
    var alertConfig: DialogConfig?
    
    private let addContactUseCase: SaveContactUseCase
    let permissionStatus: ContactsPermissionStatus
    
    init(
        addContactUseCase: SaveContactUseCase,
        getCurrentCountryUseCase: GetCurrentCountryUseCase,
        permissionStatus: ContactsPermissionStatus
    ) {
        self.addContactUseCase = addContactUseCase
        self.permissionStatus = permissionStatus
        self.syncContactToPhone = self.permissionStatus == .authorized
        self.selectedCountry = try? getCurrentCountryUseCase.execute()
    }
    
    func addContact()async{
        guard permissionStatus == .authorized else {
            alertConfig = .init(title: "Can't save contact", message: "Can't save contact right now, try again later.", actions: [
                .init(title: "OK")
            ])
            return
        }
        do {
            let payload = CreateContactPayload(firstName: firstName, lastName: lastName, phoneNumber: phone)
            try await addContactUseCase.execute(payload: payload)
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
    
    var isSaveEnabled: Bool {
        return phone.isNotEmptyString
    }
}
