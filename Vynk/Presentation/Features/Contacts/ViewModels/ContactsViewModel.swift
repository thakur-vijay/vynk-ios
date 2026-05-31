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
    private let requestContactPermissionUseCase: RequestContactsPermissionUseCase
    private let fetchPermissionStatusUseCase: FetchPermissionStatusUseCase
    private let fetchDeviceContactsUseCase: FetchDeviceContactsUseCase
    private let groupVynkContactsUseCase: GroupVynkContactsUseCase
    
    init(
        requestContactPermissionUseCase: RequestContactsPermissionUseCase,
        fetchPermissionStatusUseCase: FetchPermissionStatusUseCase,
        fetchDeviceContactsUseCase: FetchDeviceContactsUseCase,
        groupVynkContactsUseCase: GroupVynkContactsUseCase
    ) {
        self.requestContactPermissionUseCase = requestContactPermissionUseCase
        self.fetchPermissionStatusUseCase = fetchPermissionStatusUseCase
        self.fetchDeviceContactsUseCase = fetchDeviceContactsUseCase
        self.groupVynkContactsUseCase = groupVynkContactsUseCase
    }
    
    var contacts: [DeviceContact] = []
    var contactsOnVynkSections: [ContactSectionModel] = []
    
    func fetchContacts()async{
        do {
            let permission = fetchPermissionStatusUseCase.execute()
            switch permission {
            case .notDetermined:
                let isGranted = try await requestContactPermissionUseCase.execute()
                if isGranted {
                    contacts = try await fetchDeviceContactsUseCase.execute()
                    AppLogger.debug(contacts.count, tag: String(describing: self))
                    contacts.forEach { contact in
                        AppLogger.debug(contact.phoneNumbers, tag: "Number")
                    }
                }else {
                    AppLogger.debug("Permission Denied", tag: String(describing: self))

                }
            case .denied:
                AppLogger.debug("Permission Denied", tag: String(describing: self))
            case .restricted:
                AppLogger.debug("Permission Restricted", tag: String(describing: self))
            case .authorized:
                AppLogger.debug("Permission Authorized", tag: String(describing: self))
                contacts = try await fetchDeviceContactsUseCase.execute()
                contacts.forEach { contact in
                    AppLogger.debug(contact.phoneNumbers, contact.id, contact.fullName, tag: "ContactModel")
                }
                AppLogger.debug(contacts.count, tag: String(describing: self))
            }
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
    
    func fetchVynkContacts(){
        contactsOnVynkSections = groupVynkContactsUseCase.execute(contacts: MockDataFactory.makeVynkContacts(count: 50))
    }
}
