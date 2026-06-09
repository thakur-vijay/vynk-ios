//
//  AddContactDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI

final class AddContactDIContainer {
    
    private let countryPickerDIContainer: CountryPickerDIContainer
    private let repository: ContactsRepository
    private let permissionUseCase: ContactsPermissionUseCase
    private let database: AppDatabase
    
    init(
        countryPickerDIContainer: CountryPickerDIContainer,
        repository: ContactsRepository,
        permissionUseCase: ContactsPermissionUseCase,
        database: AppDatabase
    ) {
        self.countryPickerDIContainer = countryPickerDIContainer
        self.repository = repository
        self.permissionUseCase = permissionUseCase
        self.database = database
    }

    func makeViewModel() -> AddContactViewModel {
        let useCase = SaveContactUseCase(repository: repository)

        return AddContactViewModel(
            addContactUseCase: useCase,
            getCurrentCountryUseCase: countryPickerDIContainer.makeGetCurrentCountryUseCase(),
           permissionUseCase: permissionUseCase
        )
    }

    func makeAddContactView(onClose: @escaping ()->()) -> AddContactView {
        AddContactView(
            viewModel: makeViewModel(),
            diContainer: self,
            onClose: onClose
        )
    }
    
    func makeCountryPickerView(
        selectedCountry: CountryModel?,
        onClose: @escaping (CountryModel?) -> Void
        
    ) -> CountryPickerView {
        
        countryPickerDIContainer.makeCountryPickerView(
            
            selectedCountry: selectedCountry,
            
            onClose: onClose
            
        )
        
    }
}
