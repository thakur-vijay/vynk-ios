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
}
