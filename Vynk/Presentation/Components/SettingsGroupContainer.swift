//
//  SettingsGroupContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 27/05/26.
//

import SwiftUI

struct SettingsGroupContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(
            AppColors.white,
            in: .rect(cornerRadius: AppRadius.xl, style: .continuous)
        )
        .clipShape(.rect(cornerRadius: AppRadius.xl, style: .continuous))
    }
}
