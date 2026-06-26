//
//  MediaThumbnailCache.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import UIKit

final class MediaThumbnailCache {

    private let cache = NSCache<NSString, UIImage>()

    init() {
        cache.countLimit = 300
        cache.totalCostLimit = 50 * 1024 * 1024
    }

    func image(for assetId: String, size: CGSize) -> UIImage? {
        cache.object(
            forKey: cacheKey(assetId: assetId, size: size) as NSString
        )
    }

    func setImage(_ image: UIImage, for assetId: String, size: CGSize) {
        cache.setObject(
            image,
            forKey: cacheKey(assetId: assetId, size: size) as NSString,
            cost: image.memoryCost
        )
    }

    func removeAll() {
        cache.removeAllObjects()
    }

    private func cacheKey(assetId: String, size: CGSize) -> String {
        "\(assetId)-\(Int(size.width))x\(Int(size.height))"
    }
}

private extension UIImage {

    var memoryCost: Int {
        guard let cgImage else {
            return 1
        }

        return cgImage.bytesPerRow * cgImage.height
    }
}
