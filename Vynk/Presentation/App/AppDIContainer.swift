//
//  AppDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

final class AppDIContainer {
    private let configuration = AppConfiguration.shared
    lazy var appRouter: AppRouter = {
        AppRouter()
    }()
    
    lazy var apiClient: APIClient = {
        URLSessionAPIClient(configuration: NetworkConfiguration(baseURL: configuration.baseURL))
    }()
    
    lazy var appDatabase: AppDatabase = {
        do {
            return try AppDatabase()
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }()
    
    lazy var authDIContainer: AuthDIContainer = {
        AuthDIContainer(apiClient: apiClient)
    }()
    
    lazy var contactsDIContainer: ContactsDIContainer = {
        ContactsDIContainer(database: appDatabase, repository: contactsRepository)
    }()
    
    lazy var chatsDIContainer: ChatsDIContainer = {
        ChatsDIContainer(
            contactsDIContainer: contactsDIContainer,
            addContactDIContainer: addContactDIContainer,
            inviteDIContainer: inviteDIContainer,
            cameraDIContainer: cameraDIContainer,
            appPreferences: appPreferences
        )
    }()
    
    lazy var settingsDIContainer: SettingsDIContainer = {
        SettingsDIContainer(
            appLockManager: appLockManager
        )
    }()
    
    lazy var countryPickerDIContainer: CountryPickerDIContainer = {
        CountryPickerDIContainer()
    }()
    
    lazy var addContactDIContainer: AddContactDIContainer = {
        AddContactDIContainer(
            countryPickerDIContainer: countryPickerDIContainer,
            repository: contactsRepository,
            database: appDatabase
        )
    }()

    lazy var inviteDIContainer: InviteDIContainer = {
        InviteDIContainer()
    }()
    
    lazy var appPreferences: AppPreferences = {
        AppPreferences()
    }()
    
    lazy var deviceContactsDataSource: DeviceContactsDataSource = {
        DeviceContactsDataSource()
    }()

    lazy var localContactsDataSource: LocalContactsDataSource = {
        LocalContactsDataSource(database: appDatabase)
    }()

    lazy var contactsRepository: ContactsRepository = {
        DefaultContactsRepository(
            deviceDataSource: deviceContactsDataSource,
            localDataSource: localContactsDataSource
        )
    }()
    
    lazy var mediaPickerDIContainer: MediaPickerDIContainer = {
        MediaPickerDIContainer()
    }()
    
    lazy var appLockDIContainer: AppLockDIContainer = {
        AppLockDIContainer(appPreferences: appPreferences)
    }()
    
    lazy var appLockManager: AppLockManager = {
        AppLockManager(preferences: appPreferences)
    }()
    
    lazy var cameraDIContainer: CameraDIContainer = {
        CameraDIContainer()
    }()
}
