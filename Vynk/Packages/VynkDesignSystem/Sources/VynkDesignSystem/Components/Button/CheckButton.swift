//
//  CheckButton.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

@available(iOS 26.0, *)
public struct CheckButton: ToolbarContent {
    let isEnabled: Bool
    var placement: ToolbarItemPlacement
    let action: ()->()
    
    public init(
        isEnabled: Bool,
        placement: ToolbarItemPlacement = .topBarTrailing,
        action: @escaping () -> Void
    ) {
        self.isEnabled = isEnabled
        self.placement = placement
        self.action = action
    }
    
    public var body: some ToolbarContent {
        if isEnabled {
            ProminentToolbarButton(
                icon: AppSymbols.checkmark.name,
                accent: AppColors.accent,
                placement: placement,
                action: action
            )
            
        }else {
            ProminentToolbarButton(
                icon: AppSymbols.checkmark.name,
                accent: AppColors.contentDeemphasized,
                placement: placement
            ) {
               
            }
        }
    }
}
