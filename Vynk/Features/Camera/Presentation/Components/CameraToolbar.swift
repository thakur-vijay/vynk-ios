//
//  CameraToolbar.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI
import VynkCameraKit

struct CameraToolbar: View {
    let flashMode: CameraFlashMode
    let mode: CameraMode
    let isRecording: Bool
    let time: TimeInterval
    let onClose: ()->()
    let onFlashModeTap: ()->()
    var body: some View {
        HStack {
            CameraActionButton(icon: AppSymbols.close.name, action: onClose)
                .opacity(isRecording ? 0 : 1)
                .allowsHitTesting(!isRecording)
            
            Spacer()
            CameraActionButton(
                icon: flashMode.symbol,
                iconTint: flashMode.iconTint,
                background: flashMode.background,
                action: onFlashModeTap
            )
            .opacity(isRecording ? 0 : 1)
            .allowsHitTesting(!isRecording)
        }
        .padding(.horizontal)
        .overlay {
            if mode == .video {
                RecordingTimerView(time: time, isRecording: isRecording)
            }
        }
    }
}
