//
//  AddContactViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import Foundation
import VynkCountryPicker

@MainActor
@Observable
final class AddContactViewModel {
    var firstName: String = ""
    var lastName: String = ""
    var phone: String = ""
    var syncContactToPhone: Bool = false
    var isCountryPickerPresented: Bool = false
    var isDiscardConfirmationDialogPresented: Bool = false
    var selectedCountry: CountryModel?
    var alertConfig: DialogConfig?
    var permissionStatus: ContactsPermissionStatus = .notDetermined
    
    private let addContactUseCase: SaveContactUseCase
    private let permissionUseCase: ContactsPermissionUseCase

    
    init(
        addContactUseCase: SaveContactUseCase,
        permissionUseCase: ContactsPermissionUseCase
    ) {
        self.addContactUseCase = addContactUseCase
        self.permissionUseCase = permissionUseCase
        self.selectedCountry = try? CountryPickerService.currentCountry()
    }
    
    func prepareSyncToPhone() async {
        permissionStatus = await permissionUseCase.status()
        syncContactToPhone = permissionStatus == .authorized
    }
    
    func handleSyncToPhone(newValue: Bool) {
        if permissionStatus == .authorized {
            syncContactToPhone = newValue
        }else {
            alertConfig = .init(title: "Allow Vynk to access your contacts", message: "Tap Open Settings and turn on Contacts to allow access", actions: [
                .init(title: "Cancel"),
                .init(title: "Open Settings", action: AppSettingsOpener.open),
            ])
        }
    }
    
    func addContact()async{
        let permissionStatus = await permissionUseCase.status()
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
