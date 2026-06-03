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
        ContactsDIContainer()
    }()
    
    lazy var chatsDIContainer: ChatsDIContainer = {
        ChatsDIContainer(
            contactsDIContainer: contactsDIContainer,
            addContactDIContainer: addContactDIContainer,
            inviteDIContainer: inviteDIContainer
        )
    }()
    
    lazy var countryPickerDIContainer: CountryPickerDIContainer = {
        CountryPickerDIContainer()
    }()
    
    lazy var addContactDIContainer: AddContactDIContainer = {
        AddContactDIContainer(countryPickerDIContainer: countryPickerDIContainer)
    }()

    lazy var inviteDIContainer: InviteDIContainer = {
        InviteDIContainer()
    }()
    
}
