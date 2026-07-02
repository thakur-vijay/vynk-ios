//
//  AddContactViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import Foundation
import VynkCountryPicker
import SwiftUI

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
    var alertConfig: DialogConfiguration?
    var confirmationDialogConfig: DialogConfiguration?
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
    
    func presentDiscardConfirmationDialog(onClose: @escaping ()->()){
        confirmationDialogConfig = .init(
            title: "Discard changes?",
            message: "Are you sure you want to discard this new contact?",
            actions: [
                .init(title: "Discard changes", role: .destructive, action: onClose),
                .init(title: "Keep editing") {},
            ]
        )
    }
    
    func handleSyncToPhone(newValue: Bool) {
        if permissionStatus == .authorized {
            syncContactToPhone = newValue
        }else {
            alertConfig = .init(title: "Allow Vynk to access your contacts", message: "Tap Open Settings and turn on Contacts to allow access", actions: [
                .init(title: "Cancel"),
                .init(title: "Open Settings", action: AppSettings.open),
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
            Log.error(error.localizedDescription, String(describing: self))
        }
    }
    
    var isSaveEnabled: Bool {
        return phone.isNotBlank
    }
}
