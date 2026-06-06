//
//  MediaAsset.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation

struct MediaAsset: Identifiable, Hashable {

    let id: String

    let mediaType: MediaType

    let duration: TimeInterval?

    let creationDate: Date?
    
    let pixelWidth: Int
    
    let pixelHeight: Int

}

extension MediaAsset {
    func previewSize(maxWidth: CGFloat = 320, maxHeight: CGFloat = 420) -> CGSize {
        guard pixelWidth > 0, pixelHeight > 0 else {
            return CGSize(width: maxWidth, height: maxWidth)
        }

        let aspectRatio = CGFloat(pixelWidth) / CGFloat(pixelHeight)

        var width = maxWidth
        var height = width / aspectRatio

        if height > maxHeight {
            height = maxHeight
            width = height * aspectRatio
        }

        return CGSize(width: width, height: height)
    }
}

enum MediaType {

    case image

    case video

}
