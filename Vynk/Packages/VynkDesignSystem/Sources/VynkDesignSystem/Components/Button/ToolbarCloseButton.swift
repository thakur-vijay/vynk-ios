//
//  ToolbarCloseButton.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

@available(iOS 26.0, *)
public struct ToolbarCloseButton: ToolbarContent {
    var placement: ToolbarItemPlacement
    let onClose: ()->()
    
    public init(
        placement: ToolbarItemPlacement = .topBarTrailing,
        onClose: @escaping () -> Void
    ) {
        self.placement = placement
        self.onClose = onClose
    }
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button("", systemImage: AppSymbols.close.name, role: .close, action: onClose)
        }
    }
}
