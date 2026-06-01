//
//  ProminentToolbarButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import SwiftUI

struct ProminentToolbarButton: ToolbarContent {
    
    var icon: String = AppIcons.plus
    var accent: Color = AppColors.accent
    var placement: ToolbarItemPlacement = .topBarTrailing
    let action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: action) {
                Image(systemName: icon)
            }
    //        .frame(width: 28, height: 28)
            .tint(accent)
            .buttonStyle(.glassProminent)
        }
    }
}
