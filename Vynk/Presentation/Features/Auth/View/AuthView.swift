//
//  AuthView.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI

struct AuthView: View {
    
    @State private var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome to Vynk")
            
            Button("Continue with Phone Number") {
                viewModel.continueWithPhoneNumber()
            }
        }
    }
}
