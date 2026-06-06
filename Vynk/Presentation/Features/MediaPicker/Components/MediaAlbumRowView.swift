//
//  MediaAlbumRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

struct MediaAlbumRowView: View {
    let album: MediaAlbum
    let thumbnailPointSize: CGSize
    let thumbnailPixelSize: CGSize
    let loadThumbnailIfNeed: (_ assetId: String, _ size: CGSize) async -> UIImage?

    var body: some View {
        HStack {
            MediaCellView(
                size: thumbnailPointSize,
                cornerRadius: AppRadius.sm
            ) {
                await loadThumbnailIfNeed(
                    album.coverAssetId ?? "",
                    thumbnailPixelSize
                )
            }

            Text(album.title)
        }
    }
}
