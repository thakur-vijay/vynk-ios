//
//  MediaAssetMapper.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation

enum MediaAssetMapper {
    static func map(
        _ asset: MediaAsset
    ) -> MediaModel {
        MediaModel(
            id: asset.id,
            mediaType: asset.mediaType,
            duration: asset.duration?.formatDuration() ?? "",
            creationDate: asset.creationDate ?? .now,
            pixelWidth: asset.pixelWidth,
            pixelHeight: asset.pixelHeight,
            previewSize: asset.previewSize()
        )
    }
}
