//
//  AlertModifer.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func alert(_ config: DialogConfig, isPresented: Binding<Bool>)-> some View {
        self
            .alert(config.title, isPresented: isPresented) {
                ForEach(config.actions) { action in
                    Button(role: action.role, action: action.action) {
                        Text(action.title)
                    }
                }
            } message: {
                Text(config.message ?? "")
            }
    }
    
    @ViewBuilder
    func alert(_ config: Binding<DialogConfig?>)-> some View {
        if let configResult = config.wrappedValue{
            self
                .alert(configResult.title, isPresented: .constant(true)) {
                    ForEach(configResult.actions) { action in
                        Button(role: action.role, action: {
                            config.wrappedValue = nil
                            action.action()
                        }) {
                            Text(action.title)
                        }
                    }
                } message: {
                    Text(configResult.message ?? "")
                }
        }else {
            self
        }
    }
}
