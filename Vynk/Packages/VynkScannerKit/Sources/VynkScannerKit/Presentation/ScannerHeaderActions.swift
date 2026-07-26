//
//  ScannerHeaderActions.swift
//  VynkScannerKit
//
//  Created by Vijay Thakur on 25/07/26.
//

import SwiftUI
import VynkCameraKit
import VynkDesignSystem

struct ScannerHeaderActions: View {
    let flashMode: CameraFlashMode
    let onClose: ()->()
    let onFlashModeTap: ()->()
    var body: some View {
        HStack {
            actionButton(AppSymbols.close.name, action: onClose)
            Spacer()
            actionButton(flashMode.symbol, action: onFlashModeTap)
        }
        .padding()
    }
    
    @ViewBuilder
    func actionButton(_ icon: String, action: @escaping ()-> ())-> some View {
        Button("", systemImage: icon, action: action)
            .font(AppFont.title1Regular)
            .tint(AppColors.white)
    }
}

