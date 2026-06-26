//
//  MediaAlbumListView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

struct MediaAlbumListView: View {
    let albums: [MediaAlbum]
    let loadThumbnailIfNeed: (_ assetId: String, _ size: CGSize)async-> UIImage?
    @Environment(\.displayScale) private var displayScale
    var body: some View {
        let thumbnailPointSize = AppSizes.mediaSizeMd
        let thumbnailPixelSize = thumbnailPointSize.scaled(by: displayScale)
        
        List {
            Section {
                ForEach(albums) { album in
                    NavigationLink(value: album) {
                        MediaAlbumRowView(
                            album: album,
                            thumbnailPointSize: thumbnailPointSize,
                            thumbnailPixelSize: thumbnailPixelSize,
                            loadThumbnailIfNeed: loadThumbnailIfNeed
                            
                        )
                    }
                }
                
            }
            
        }
    }
}
