//
//  SwiftUIView.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func appConfirmationDialog(_ config: Binding<DialogConfiguration?>)-> some View {
        if let configResult = config.wrappedValue{
            self
                .confirmationDialog(configResult.title, isPresented: .init(get: {
                    config.wrappedValue != nil
                }, set: { newValue in
                    if !newValue {
                        config.wrappedValue = nil
                    }
                })) {
                    ForEach(configResult.actions) { action in
                        Button(role: action.role, action: {
                            config.wrappedValue = nil
                            action.action()
                        }) {
                            Text(action.title)
                        }
                    }
                } message: {
                    if let message = configResult.message{
                        Text(message)
                    }
                }
        }else {
            self
        }
    }
}
