//
//  ContactsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

final class ContactsDIContainer {
    private let database: AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
    
    func makeContactsViewModel()->ContactsViewModel {
        
        let dataSource = DeviceContactsDataSource()
        let localSource = LocalContactsDataSource(database: database)
        let repository = DefaultContactsRepository(deviceDataSource: dataSource, localDataSource: localSource)
        let contactsPermissionUseCase = ContactsPermissionUseCase(repository: repository)
        let fetchDeviceContactsUseCase = FetchDeviceContactsUseCase(repository: repository)
        let groupVynkContactsUseCase = GroupVynkContactsUseCase()
        let syncContactsUseCase = SyncContactsUseCase(repository: repository)
        return ContactsViewModel(
            contactsPermissionUseCase: contactsPermissionUseCase,
            fetchDeviceContactsUseCase: fetchDeviceContactsUseCase,
            groupVynkContactsUseCase: groupVynkContactsUseCase,
            syncContactsUseCase: syncContactsUseCase
        )
    }
    
    @ViewBuilder
    func makeContactsView(onInviteTap: @escaping (DeviceContact)->()) -> ContactsView {
        ContactsView(
            viewModel: makeContactsViewModel(),
            onInviteTap: onInviteTap
        )
    }
}
