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
    var contacts: [DeviceContact] = []
    
    private let requestContactPermissionUseCase: RequestContactsPermissionUseCase
    private let fetchPermissionStatusUseCase: FetchPermissionStatusUseCase
    private let fetchDeviceContactsUseCase: FetchDeviceContactsUseCase
    
    init(requestContactPermissionUseCase: RequestContactsPermissionUseCase, fetchPermissionStatusUseCase: FetchPermissionStatusUseCase, fetchDeviceContactsUseCase: FetchDeviceContactsUseCase) {
        self.requestContactPermissionUseCase = requestContactPermissionUseCase
        self.fetchPermissionStatusUseCase = fetchPermissionStatusUseCase
        self.fetchDeviceContactsUseCase = fetchDeviceContactsUseCase
    }
    
    func fetchContacts()async throws{
        do {
            let permission = fetchPermissionStatusUseCase.execute()
            switch permission {
            case .notDetermined:
                let isGranted = try await requestContactPermissionUseCase.execute()
                if isGranted {
                    let contacts = try await fetchDeviceContactsUseCase.execute()
                    AppLogger.debug(contacts.count, tag: self)
                }else {
                    AppLogger.debug("Permission Denied", tag: self)

                }
            case .denied:
                AppLogger.debug("Permission Denied", tag: self)
            case .restricted:
                AppLogger.debug("Permission Restricted", tag: self)
            case .authorized:
                AppLogger.debug("Permission Authorized", tag: self)
                let contacts = try await fetchDeviceContactsUseCase.execute()
                AppLogger.debug(contacts.count, tag: self)
            }
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
}
