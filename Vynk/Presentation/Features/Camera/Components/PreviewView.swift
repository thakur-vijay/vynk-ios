//
//  PreviewView.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import AVFoundation
import UIKit

final class PreviewView: UIView {

    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    var previewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        previewLayer.frame = bounds
        previewLayer.videoGravity = .resizeAspectFill
    }
}
