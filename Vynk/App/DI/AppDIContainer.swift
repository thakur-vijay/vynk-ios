//
//  AppDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation
import VynkDatabaseKit

final class AppDIContainer {
    private let configuration = AppConfiguration.shared
    lazy var appRouter: AppRouter = {
        AppRouter()
    }()
    
    lazy var apiClient: APIClient = {
        URLSessionAPIClient(configuration: NetworkConfiguration(baseURL: configuration.baseURL))
    }()
    
    lazy var databaseInfraDIContainer: DatabaseInfraDIContainer = {
        DatabaseInfraDIContainer()
    }()
    
    lazy var authDIContainer: AuthDIContainer = {
        AuthDIContainer(apiClient: apiClient)
    }()
    
    lazy var contactsDIContainer: ContactsDIContainer = {
        ContactsDIContainer(
            database: databaseInfraDIContainer.appDatabase,
            repository: contactsRepository
        )
    }()
    
    lazy var chatsDIContainer: ChatsDIContainer = {
        ChatsDIContainer(
            contactsDIContainer: contactsDIContainer,
            addContactDIContainer: addContactDIContainer,
            inviteDIContainer: inviteDIContainer,
            cameraDIContainer: cameraDIContainer,
            chatListsDIContainer: chatListsDIContainer,
            appPreferences: appPreferences,
            appRouter: appRouter
        )
    }()
    
    lazy var settingsDIContainer: SettingsDIContainer = {
        SettingsDIContainer(
            appLockManager: appLockManager,
            brightnessManager: screenBrightnessManager,
            listsDIContainer: listsDIContainer,
            scannerDIContainer: scannerDIContainer,
            router: appRouter.settingsRouter,
            chatNavigator: appRouter
        )
    }()
    
    lazy var countryPickerDIContainer: CountryPickerDIContainer = {
        CountryPickerDIContainer()
    }()
    
    lazy var addContactDIContainer: AddContactDIContainer = {
        AddContactDIContainer(
            countryPickerDIContainer: countryPickerDIContainer,
            repository: contactsRepository,
            permissionUseCase: contactsDIContainer.makeContactsPermissionUseCase(),
            database: databaseInfraDIContainer.appDatabase
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
        LocalContactsDataSource(
            database: databaseInfraDIContainer.appDatabase
        )
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
        CameraDIContainer(cameraEngine: cameraInfraDIContainer.cameraEngine)
    }()
    
    lazy var listsDIContainer: ListsDIContainer = {
        ListsDIContainer(chatListsDIContainer: chatListsDIContainer)
    }()
    
    lazy var chatListsDIContainer: ChatListsDIContainer = {
        ChatListsDIContainer(
            database: databaseInfraDIContainer.appDatabase
        )
    }()
    
    lazy var screenBrightnessManager: ScreenBrightnessManaging = {
        ScreenBrightnessManager()
    }()
    
    lazy var scannerDIContainer: ScannerDIContainer = {
        ScannerDIContainer(cameraEngine: cameraInfraDIContainer.cameraEngine)
    }()
    
    lazy var cameraInfraDIContainer: CameraInfraDIContainer = {
        CameraInfraDIContainer()
    }()
}
