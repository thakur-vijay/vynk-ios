//
//  AuthRepositoryImpl.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    private let authRemoteDataSource: AuthRemoteDataSource
    init(authRemoteDataSource: AuthRemoteDataSource) {
        self.authRemoteDataSource = authRemoteDataSource
    }
    
    func login() async throws->AuthSession {
        let response = try await authRemoteDataSource.login()
        return AuthSessionMapper.map(from: response)
    }
}
