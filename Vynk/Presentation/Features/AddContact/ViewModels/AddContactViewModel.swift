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
    var syncContactToPhone: Bool = false
    var isCountryPickerPresented: Bool = false
    var isDiscardConfirmationDialogPresented: Bool = false
    var selectedCountry: CountryModel?
    
    private let addContactUseCase: SaveContactUseCase
    
    init(
        addContactUseCase: SaveContactUseCase,
        getCurrentCountryUseCase: GetCurrentCountryUseCase
    ) {
        self.addContactUseCase = addContactUseCase
        self.selectedCountry = try? getCurrentCountryUseCase.execute()
    }
    
    func addContact()async{
        do {
            let payload = CreateContactPayload(firstName: firstName, lastName: lastName, phoneNumber: phone)
            try await addContactUseCase.execute(payload: payload)
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
    
    var isSaveEnabled: Bool {
        let condition  = firstName.isNotEmptyString && lastName.isNotEmptyString && phone.isNotEmptyString
//        AppLogger.debug(firstName.isNotEmptyString, tag: String(describing: self))
//        AppLogger.debug(lastName.isNotEmptyString, tag: String(describing: self))
//        AppLogger.debug(phone.isNotEmptyString, tag: String(describing: self))
        AppLogger.debug(condition, tag: String(describing: self))
        return condition
    }
}
