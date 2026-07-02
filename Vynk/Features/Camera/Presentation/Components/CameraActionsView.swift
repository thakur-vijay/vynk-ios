//
//  CameraActions.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI
import VynkCameraKit


struct CameraActionsView: View {
    let mode: CameraMode
    let position: CameraPosition
    let isCaptureDisabled: Bool
    let isRecording: Bool
    let zoomFactor: CGFloat
    let onCapture: ()->()
    let onSwitch: ()->()
    let onPhotosTap: ()->()
    let onFilterTap: ()->()
    let onZoomTap: ()->()
    var body: some View {
        HStack {
            CameraActionButton(icon: AppSymbols.photo.name, size: AppSizes.buttonHeightLG, action: onPhotosTap)
                .opacity(isRecording ? 0 : 1)
                .allowsHitTesting(!isRecording)
            Spacer(minLength: 0)
            
            CameraActionButton(icon: AppSymbols.filter.name, action: onFilterTap)
                .opacity(isRecording ? 0 : 1)
                .allowsHitTesting(!isRecording)
            
            Spacer(minLength: 0)
            
            CameraCaptureButton(
                mode: mode,
                isRecording: isRecording,
                isDisabled: isCaptureDisabled,
                onCapture: onCapture
            )
            
            Spacer(minLength: 0)
            
            CameraActionButton(label: "\(Int(zoomFactor))x", action: onZoomTap)
                .opacity((isRecording || position == .front) ? 0 : 1)
                .allowsHitTesting(!isRecording && position == .back)

            Spacer(minLength: 0)
            CameraActionButton(icon: AppSymbols.switchPath.name, size: AppSizes.buttonHeightLG, action: onSwitch)
        }
        .padding(.horizontal)
    }
}
