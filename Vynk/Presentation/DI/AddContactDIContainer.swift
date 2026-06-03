//
//  AddContactDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI

final class AddContactDIContainer {
    
    private let countryPickerDIContainer: CountryPickerDIContainer
    private let database: AppDatabase
    
    init(
        countryPickerDIContainer: CountryPickerDIContainer,
        database: AppDatabase
    ) {
        self.countryPickerDIContainer = countryPickerDIContainer
        self.database = database
    }

    func makeViewModel() -> AddContactViewModel {
        let dataSource = DeviceContactsDataSource()
        let localSource = LocalContactsDataSource(database: database)
        let repository = DefaultContactsRepository(deviceDataSource: dataSource, localDataSource: localSource)
        let useCase = SaveContactUseCase(repository: repository)

        return AddContactViewModel(
            addContactUseCase: useCase,
            getCurrentCountryUseCase: countryPickerDIContainer.makeGetCurrentCountryUseCase()
        )
    }

    func makeAddContactView() -> AddContactView {
        AddContactView(
            viewModel: makeViewModel(),
            diContainer: self
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
