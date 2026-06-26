//
//  CameraFlashMode+Symbol.swift
//  Vynk
//
//  Created by Vijay Thakur on 10/06/26.
//

import SwiftUI
import VynkCameraKit

extension CameraFlashMode {
    var symbol: String {
        switch self {
        case .off: AppIcons.flashOff
        case .auto: AppIcons.flashAuto
        case .on: AppIcons.flashOn
        }
    }
    
    var iconTint: Color {
        if self == .off {
            return AppColors.white
        }else {
            return AppColors.contentDefault
        }
    }
    
    var background: Color {
        if self == .off {
            return AppColors.secondarySurface
        }else {
            return AppColors.yellow
        }
    }
}
