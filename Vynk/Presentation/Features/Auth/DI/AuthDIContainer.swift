//
//  AuthDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

@MainActor
final class AuthDIContainer {
    
    func makeAuthView()-> AuthView {
        AuthView(viewModel: makeAuthViewModel())
    }
    
    private func makeAuthViewModel()->AuthViewModel {
        AuthViewModel(loginUseCase: makeLoginUseCase())
    }
    
    private func makeLoginUseCase()->LoginUseCase {
        LoginUseCase(repository: makeAuthRepository())
    }
    
    private func makeAuthRepository()->AuthRepository {
        AuthRepositoryImpl()
    }
}
