//
//  ShareQRToolbar.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI

struct ShareQRToolbar: ToolbarContent {
    let action: ()->()
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("", systemImage: AppSymbols.Share.share.name, action: action)
        }
    }
}
