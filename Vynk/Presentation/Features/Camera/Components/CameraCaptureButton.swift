//
//  CameraCaptureButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 09/06/26.
//

import SwiftUI

struct CameraCaptureButton: View {
    let mode: CameraMode
    let isDisabled: Bool
    let onCapture: ()->()
    var body: some View {
        Button(action: onCapture) {
            Circle()
                .stroke(.white, lineWidth: 4.0)
                .frame(AppSizes.captureButtonSize)
                .overlay {
                    Circle()
                        .fill(fillColor)
                        .frame(width: AppSizes.captureButtonSize.width - 8, height: AppSizes.captureButtonSize.height - 8)
                }
        }
        .disabled(isDisabled)
    }
    
    var fillColor: Color {
        mode == .photo ? .white : .red
    }
}
