//
//  ConfirmationDialogModifier.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func confirmationDialog(_ config: DialogConfig, isPresented: Binding<Bool>)-> some View {
        self
            .confirmationDialog(config.title, isPresented: isPresented) {
                ForEach(config.actions) { action in
                    Button(role: action.role, action: action.action) {
                        Text(action.title)
                    }
                }
            } message: {
                Text(config.message ?? "")
            }
    }
}
