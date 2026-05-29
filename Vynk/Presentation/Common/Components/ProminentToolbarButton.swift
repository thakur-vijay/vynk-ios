//
//  ProminentToolbarButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import SwiftUI

struct ProminentToolbarButton: View {
    
    let icon: String = AppIcons.plus
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
        }
        .frame(width: 28, height: 28)
        .tint(AppColors.accent)
        .buttonStyle(.glassProminent)
    }
}
