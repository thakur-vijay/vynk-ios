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
        case .off: return AppSymbols.flashOff.name
        case .auto: return AppSymbols.flashAuto.name
        case .on: return AppSymbols.flashOn.name
        @unknown default:
            return ""
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
