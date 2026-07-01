//
//  MediaAlbumRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

@available(iOS 16.0, *)
struct MediaAlbumRowView: View {
    let album: MediaAlbum
    let thumbnailPointSize: CGSize
    let thumbnailPixelSize: CGSize
    let loadThumbnailIfNeed: (_ assetId: String, _ size: CGSize) async -> UIImage?

    var body: some View {
        HStack {
            MediaCellView(
                size: thumbnailPointSize,
                cornerRadius: 10
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
