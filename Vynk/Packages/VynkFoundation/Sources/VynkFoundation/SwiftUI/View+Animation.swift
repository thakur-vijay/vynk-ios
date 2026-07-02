//
//  File.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

public extension View {
    func performWithoutAnimation(action: @escaping ()->()) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
    }
}
