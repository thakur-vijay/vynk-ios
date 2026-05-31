//
//  ContactsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

final class ContactsDIContainer {
    
    func makeContactsViewModel()->ContactsViewModel {
        
        let dataSource = DeviceContactsDataSource()
        let repository = DefaultContactsRepository(dataSource: dataSource)
        let requestContactPermissionUseCase = RequestContactsPermissionUseCase(repository: repository)
        let fetchPermissionStatusUseCase = FetchPermissionStatusUseCase(repository: repository)
        let fetchDeviceContactsUseCase = FetchDeviceContactsUseCase(repository: repository)
        let groupVynkContactsUseCase = GroupVynkContactsUseCase()
        return ContactsViewModel(
            requestContactPermissionUseCase: requestContactPermissionUseCase,
            fetchPermissionStatusUseCase: fetchPermissionStatusUseCase,
            fetchDeviceContactsUseCase: fetchDeviceContactsUseCase,
            groupVynkContactsUseCase: groupVynkContactsUseCase
        )
    }
    
    @ViewBuilder
    func makeContactsView() -> some View {
        ContactsView(
            viewModel: makeContactsViewModel()
        )
    }
}
