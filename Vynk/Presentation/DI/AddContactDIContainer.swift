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
    private let database: AppDatabase
    
    init(
        countryPickerDIContainer: CountryPickerDIContainer,
        repository: ContactsRepository,
        database: AppDatabase
    ) {
        self.countryPickerDIContainer = countryPickerDIContainer
        self.repository = repository
        self.database = database
    }

    func makeViewModel(permissionStatus: ContactsPermissionStatus) -> AddContactViewModel {
        let useCase = SaveContactUseCase(repository: repository)

        return AddContactViewModel(
            addContactUseCase: useCase,
            getCurrentCountryUseCase: countryPickerDIContainer.makeGetCurrentCountryUseCase(),
            permissionStatus: permissionStatus
        )
    }

    func makeAddContactView(onClose: @escaping ()->()) -> AddContactView {
        AddContactView(
            viewModel: makeViewModel(permissionStatus: repository.permissionStatus()),
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
