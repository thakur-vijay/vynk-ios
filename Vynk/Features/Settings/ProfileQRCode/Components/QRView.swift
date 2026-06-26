//
//  QRView.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
    let content: String
    let size: CGFloat

    init(
        content: String,
        size: CGFloat = 200
    ) {
        self.content = content
        self.size = size
    }

    var body: some View {
        if let image = generateQRCode(from: content) {
            Image(uiImage: image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        } else {
            Image(systemName: "qrcode")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(.secondary)
        }
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        guard let data = string.data(using: .utf8) else {
            return nil
        }

        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")

        guard let outputImage = filter.outputImage else {
            return nil
        }

        let scaledImage = outputImage.transformed(
            by: CGAffineTransform(scaleX: 12, y: 12)
        )

        guard let cgImage = context.createCGImage(
            scaledImage,
            from: scaledImage.extent
        ) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}
