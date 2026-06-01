//
//  CustomContextMenu+Extensions.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import SwiftUI

extension View {
    func customContextMenu<Preview: View>(
        actions: [UIAction],
        cornerRadius: CGFloat = .greatestFiniteMagnitude,
        @ViewBuilder preview: () -> Preview
    ) -> some View {
         
        CustomContextMenu(
            actions: actions,
            content: self,
            preview: preview(),
            cornerRadius: cornerRadius
        )
    }
    
    func customContextMenu(
        actions: [UIAction],
        cornerRadius: CGFloat = AppRadius.lg
    ) -> some View {
         
        CustomContextMenu(actions: actions, content: self, preview: self, cornerRadius: cornerRadius)
    }
}

