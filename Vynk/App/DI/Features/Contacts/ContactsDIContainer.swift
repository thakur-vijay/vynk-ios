//
//  ContactsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI
import VynkDatabaseKit

final class ContactsDIContainer {
    private let database: AppDatabase
    private let repository: ContactsRepository
    
    init(
        database: AppDatabase,
        repository: ContactsRepository
    ) {
        
        self.database = database
        self.repository = repository
    }
    
    func makeContactsViewModel()->ContactsViewModel {
        let fetchDeviceContactsUseCase = FetchDeviceContactsUseCase(repository: repository)
        let groupVynkContactsUseCase = GroupVynkContactsUseCase()
        let syncContactsUseCase = SyncContactsUseCase(repository: repository)
        return ContactsViewModel(
            contactsPermissionUseCase: makeContactsPermissionUseCase(),
            fetchDeviceContactsUseCase: fetchDeviceContactsUseCase,
            groupVynkContactsUseCase: groupVynkContactsUseCase,
            syncContactsUseCase: syncContactsUseCase
        )
    }
    
    func makeContactsPermissionUseCase()->ContactsPermissionUseCase{
        ContactsPermissionUseCase(repository: repository)
    }

    @ViewBuilder
    func makeContactsView(onInviteTap: @escaping (DeviceContact)->()) -> ContactsView {
        ContactsView(
            viewModel: makeContactsViewModel(),
            onInviteTap: onInviteTap
        )
    }
}
