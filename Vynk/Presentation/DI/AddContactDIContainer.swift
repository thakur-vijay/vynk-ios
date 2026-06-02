//
//  AddContactDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI

final class AddContactDIContainer {
    
    private let countryPickerDIContainer: CountryPickerDIContainer
    
    init(countryPickerDIContainer: CountryPickerDIContainer) {
        self.countryPickerDIContainer = countryPickerDIContainer
    }

    func makeViewModel() -> AddContactViewModel {
        let dataSource = DeviceContactsDataSource()
        let repository = DefaultContactsRepository(dataSource: dataSource)
        let useCase = SaveContactUseCase(repository: repository)

        return AddContactViewModel(addContactUseCase: useCase)
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
