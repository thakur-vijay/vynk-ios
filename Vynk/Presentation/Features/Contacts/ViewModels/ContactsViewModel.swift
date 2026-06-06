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
    
    var status: ContactsPermissionStatus = .notDetermined
    var contacts: [DeviceContact] = []
    var contactsOnVynkSections: [ContactSectionModel] = []
    
    func fetchContacts()async{
        status = contactsPermissionUseCase.status()
          switch status {
          case .notDetermined:
              do {
                  let isGranted = try await contactsPermissionUseCase.request()
                  if isGranted {
                      status = .authorized
                      await loadDeviceContactsAndSyncSafely()
                  } else {
                      await loadLocalContactsSafely()
                  }

              } catch {
                  AppLogger.error(error.localizedDescription, tag: String(describing: self))
                  await loadLocalContactsSafely()
              }

          case .authorized:
              await loadDeviceContactsAndSyncSafely()
          case .denied, .restricted:
              await loadLocalContactsSafely()
          }
    }
    
    func fetchVynkContacts(){
        contactsOnVynkSections = groupVynkContactsUseCase.execute(contacts: MockDataFactory.makeVynkContacts(count: 50))
    }
    
    private func loadDeviceContactsAndSyncSafely() async {
        do {
            let deviceContacts = try await fetchDeviceContactsUseCase.execute()

            contacts = deviceContacts

            await syncLocalCacheSafely(deviceContacts)

        } catch {

            AppLogger.error(error.localizedDescription, tag: "DeviceContactsFetch")

            await loadLocalContactsSafely()

        }
    }
    
    private func syncLocalCacheSafely(
        _ deviceContacts: [DeviceContact]
    ) async {
        do {
            try await syncContactsUseCase.sync(deviceContacts: deviceContacts)
            do {
                let localContacts = try await syncContactsUseCase.fetchLocalContacts()
                if !localContacts.isEmpty {
                    contacts = localContacts
                }

            } catch {
                AppLogger.error(error.localizedDescription, tag: "LocalContactsFetchAfterSync")
            }

        } catch {
            AppLogger.error(error.localizedDescription, tag: "ContactsSync")
        }
    }
    
    private func loadLocalContactsSafely() async {
        do {

            contacts = try await syncContactsUseCase.fetchLocalContacts()

        } catch {

            contacts = []

            AppLogger.error(error.localizedDescription, tag: "LocalContactsFallback")

        }

    }
}
