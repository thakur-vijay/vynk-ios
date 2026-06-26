//
//  CameraPreview.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import SwiftUI
import AVFoundation

public struct CameraPreview: UIViewRepresentable {

    let session: AVCaptureSession
    
    public init(session: AVCaptureSession) {
        self.session = session
    }

    public func makeUIView(context: Context) -> CameraPreviewLayer {
        let view = CameraPreviewLayer()
        view.previewLayer.session = session
        view.previewLayer.videoGravity = .resizeAspectFill
        return view
    }

    public func updateUIView(
        _ uiView: CameraPreviewLayer,
        context: Context
    ) {
        uiView.previewLayer.session = session
        uiView.previewLayer.videoGravity = .resizeAspectFill
    }
}

public final class CameraPreviewLayer: UIView {

    public override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    var previewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }

    public  override func layoutSubviews() {
        super.layoutSubviews()

        previewLayer.frame = bounds
        previewLayer.videoGravity = .resizeAspectFill
    }
}
