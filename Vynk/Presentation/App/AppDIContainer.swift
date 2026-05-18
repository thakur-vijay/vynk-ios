//
//  AppDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation


@MainActor
final class AppDIContainer {
    private let configuration = AppConfiguration.shared
    lazy var appRouter: AppRouter = {
        AppRouter()
    }()
    
    lazy var authDIContainer: AuthDIContainer = {
        AuthDIContainer(apiClient: apiClient)
    }()
    
    lazy var apiClient: APIClient = {
        URLSessionAPIClient(configuration: NetworkConfiguration(baseURL: configuration.baseURL))
    }()
}
