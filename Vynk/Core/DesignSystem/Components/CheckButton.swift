//
//  CheckButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import SwiftUI

struct CheckButton: ToolbarContent {
    let isEnabled: Bool
    var placement: ToolbarItemPlacement = .topBarTrailing
    let action: ()->()
    var body: some ToolbarContent {
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
