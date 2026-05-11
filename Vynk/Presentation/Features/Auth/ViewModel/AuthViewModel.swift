//
//  AuthViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

@MainActor
@Observable
final class AuthViewModel {
    private let loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    func continueWithPhoneNumber(){
        Task {
            do {
                try await loginUseCase.execute()
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
