//
//  CameraPreview.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {

    let session: AVCaptureSession

    func makeUIView(context: Context) -> CameraPreviewLayer {
        let view = CameraPreviewLayer()
        view.previewLayer.session = session
        view.previewLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(
        _ uiView: CameraPreviewLayer,
        context: Context
    ) {
        uiView.previewLayer.session = session
        uiView.previewLayer.videoGravity = .resizeAspectFill
    }
}

final class CameraPreviewLayer: UIView {

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
