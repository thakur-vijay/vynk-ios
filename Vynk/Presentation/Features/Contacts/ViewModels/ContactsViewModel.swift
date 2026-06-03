//
//  ContactsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

@MainActor
@Observable
final class ContactsViewModel {    
    private let contactsPermissionUseCase: ContactsPermissionUseCase
    private let fetchDeviceContactsUseCase: FetchDeviceContactsUseCase
    private let groupVynkContactsUseCase: GroupVynkContactsUseCase
    private let syncContactsUseCase: SyncContactsUseCase
    init(
        contactsPermissionUseCase: ContactsPermissionUseCase,
        fetchDeviceContactsUseCase: FetchDeviceContactsUseCase,
        groupVynkContactsUseCase: GroupVynkContactsUseCase,
        syncContactsUseCase: SyncContactsUseCase,
    ) {
        self.contactsPermissionUseCase = contactsPermissionUseCase
        self.fetchDeviceContactsUseCase = fetchDeviceContactsUseCase
        self.groupVynkContactsUseCase = groupVynkContactsUseCase
        self.syncContactsUseCase = syncContactsUseCase
    }
    
    var contacts: [DeviceContact] = []
    var contactsOnVynkSections: [ContactSectionModel] = []
    
    func fetchContacts()async{
        do {
            let permission = contactsPermissionUseCase.status()
            switch permission {
            case .notDetermined:
                let isGranted = try await contactsPermissionUseCase.request()
                if isGranted {
                    let deviceContacts = try await fetchDeviceContactsUseCase.execute()
                    try await syncContactsUseCase.sync(
                        deviceContacts: deviceContacts
                    )
                    contacts = try await syncContactsUseCase.fetchLocalContacts()
                }else {
                    contacts = try await syncContactsUseCase.fetchLocalContacts()
                }
            case .denied:
                contacts = try await syncContactsUseCase.fetchLocalContacts()
            case .restricted:
                contacts = try await syncContactsUseCase.fetchLocalContacts()
            case .authorized:
                let deviceContacts = try await fetchDeviceContactsUseCase.execute()
                try await syncContactsUseCase.sync(
                    deviceContacts: deviceContacts
                )
                contacts = try await syncContactsUseCase.fetchLocalContacts()
            }
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
    
    func fetchVynkContacts(){
        contactsOnVynkSections = groupVynkContactsUseCase.execute(contacts: MockDataFactory.makeVynkContacts(count: 50))
    }
}
