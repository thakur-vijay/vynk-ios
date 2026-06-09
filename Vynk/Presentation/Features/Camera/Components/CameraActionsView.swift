//
//  CameraActions.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI

struct CameraActionsView: View {
    let mode: CameraMode
    let isCaptureDisabled: Bool
    let onCapture: ()->()
    let onSwitch: ()->()
    let onPhotosTap: ()->()
    let onFilterTap: ()->()
    let onZoomTap: ()->()
    var body: some View {
        HStack {
            CameraActionButton(icon: AppIcons.photo, size: AppSizes.buttonHeightLG, action: onPhotosTap)
            Spacer(minLength: 0)
            CameraActionButton(icon: AppIcons.filter, action: onFilterTap)
            Spacer(minLength: 0)
            CameraCaptureButton(
                mode: mode,
                isDisabled: isCaptureDisabled,
                onCapture: onCapture
            )
            Spacer(minLength: 0)
            CameraActionButton(label: "1x", action: onZoomTap)
            Spacer(minLength: 0)
            CameraActionButton(icon: AppIcons.switchPath, size: AppSizes.buttonHeightLG, action: onSwitch)
        }
        .padding(.horizontal)
    }
}
