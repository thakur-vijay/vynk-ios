//
//  ToolbarCloseButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import SwiftUI

struct ToolbarCloseButton: ToolbarContent {
    var placement: ToolbarItemPlacement = .topBarTrailing
    let onClose: ()->()
    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button("", systemImage: AppSymbols.close.name, role: .close, action: onClose)
        }
    }
}
