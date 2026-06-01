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
    var selectedCountry: CountryModel?
    
}
