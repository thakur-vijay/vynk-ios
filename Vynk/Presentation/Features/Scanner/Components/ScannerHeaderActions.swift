//
//  ScannerHeaderActions.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import SwiftUI
import VynkCameraKit

struct ScannerHeaderActions: View {
    let flashMode: CameraFlashMode
    let onClose: ()->()
    let onFlashModeTap: ()->()
    var body: some View {
        HStack {
            actionButton(AppIcons.close, action: onClose)
            Spacer()
            actionButton(flashMode.symbol, action: onFlashModeTap)
        }
        .padding()
    }
    
    @ViewBuilder
    func actionButton(_ icon: String, action: @escaping ()-> ())-> some View {
        Button("", systemImage: icon, action: action)
            .font(AppFont.title1Normal)
            .tint(AppColors.white)
    }
}

