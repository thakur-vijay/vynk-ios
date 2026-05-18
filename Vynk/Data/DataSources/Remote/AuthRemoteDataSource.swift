//
//  AuthRemoteDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

final class AuthRemoteDataSource {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func login() async throws -> LoginResponseDTO {
        try await apiClient.request(AuthEndpoint.login, as: LoginResponseDTO.self)
    }
}
