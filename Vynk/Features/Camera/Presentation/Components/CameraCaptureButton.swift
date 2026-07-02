//
//  CameraCaptureButton.swift
//  Vynk
//
//  Created by Vijay Thakur on 09/06/26.
//

import SwiftUI
import VynkCameraKit

struct CameraCaptureButton: View {
    let mode: CameraMode
    let isRecording: Bool
    let isDisabled: Bool
    let onCapture: ()->()
    var body: some View {
        Button(action: onCapture) {
            Circle()
                .stroke(.white, lineWidth: 4.0)
                .frame(captureButtonSize)
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(fillColor)
                        .frame(frame)
                }
        }
        .disabled(isDisabled)
        .animation(.smooth, value: frame)
        .animation(.smooth, value: cornerRadius)
    }
    
    var fillColor: Color {
        mode == .photo ? .white : .red
    }
    
    var frame: CGSize {
        if mode == .photo {
            return .init(width: captureButtonSize.width - 8, height: captureButtonSize.height - 8)
        }else {
            if isRecording {
                return .init(width: 34, height: 34)
            }else {
                return .init(width: captureButtonSize.width - 8, height: captureButtonSize.height - 8)
            }
        }
    }
    
    var cornerRadius: CGFloat {
        if mode == .photo {
            return captureButtonSize.width - 8
        }else {
            if isRecording {
                return 8
            }else {
                return captureButtonSize.width - 8
            }
        }
    }
    
    let captureButtonSize: CGSize = .init(width: 80, height: 80)
}
