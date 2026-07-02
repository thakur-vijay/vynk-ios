//
//  MediaAlbumListView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI
import VynkFoundation

let mediaSizeMd: CGSize = .init(width: 60, height: 60)


@available(iOS 16.0, *)
struct MediaAlbumListView: View {
    let albums: [MediaAlbum]
    let loadThumbnailIfNeed: (_ assetId: String, _ size: CGSize)async-> UIImage?
    @Environment(\.displayScale) private var displayScale
    var body: some View {
        let thumbnailPointSize = mediaSizeMd
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
