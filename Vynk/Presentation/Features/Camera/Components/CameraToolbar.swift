//
//  CameraToolbar.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI

struct CameraToolbar: View {
    let flashMode: CameraFlashMode
    let onClose: ()->()
    let onFlashModeTap: ()->()
    var body: some View {
        HStack {
            CameraActionButton(icon: AppIcons.close, action: onClose)
            Spacer()
            CameraActionButton(
                icon: flashMode.symbol,
                iconTint: flashMode.iconTint,
                background: flashMode.background,
                action: onFlashModeTap
            )
        }
        .padding(.horizontal)
    }
}
