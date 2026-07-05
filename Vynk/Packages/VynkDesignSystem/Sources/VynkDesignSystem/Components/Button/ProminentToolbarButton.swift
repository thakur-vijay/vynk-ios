//
//  ProminentToolbarButton.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

@available(iOS 17.0, *)
public struct ProminentToolbarButton: ToolbarContent {
    
    var icon: String
    var accent: Color
    var placement: ToolbarItemPlacement
    let action: () -> Void
    
    public init(
        icon: String = AppSymbols.plus.name,
        accent: Color = AppColors.accent,
        placement: ToolbarItemPlacement = .topBarTrailing,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.accent = accent
        self.placement = placement
        self.action = action
    }
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: action) {
                Image(systemName: icon)
            }
            .tint(accent)
            .glassProminentButton()
        }
    }
}
