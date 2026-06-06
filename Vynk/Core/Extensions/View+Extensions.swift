//
//  View+Extensions.swift
//  Vynk
//
//  Created by Vijay Thakur on 22/05/26.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center)-> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func clearListRowStyle(separator: Visibility = .hidden) -> some View {
        self
            .listRowSeparator(separator)
            .listRowInsets(.all, 0)
            .listRowBackground(EmptyView())
    }
    
    @ViewBuilder
    func frame(_ size: CGSize)-> some View {
        self
            .frame(width: max(size.width, 0), height: max(size.height, 0))
    }
    
    func withoutAnimation(action: @escaping ()->()) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
    }
    
}

