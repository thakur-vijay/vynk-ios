//
//  SwiftUIView.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

public struct DialogAction: Identifiable{

    public let id = UUID()

    public let title: String

    public let role: ButtonRole?

    public let action: () -> Void
    
    public init(
        title: String,
        role: ButtonRole? = nil,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.role = role
        self.action = action
    }

}
