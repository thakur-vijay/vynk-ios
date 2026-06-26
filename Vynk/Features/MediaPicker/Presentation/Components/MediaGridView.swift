//
//  MediaGridView.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI
import AVFoundation

struct MediaGridView: View {
    let assets: [MediaModel]
    let loadThumbnailIfNeed: (_ assetId: String, _ size: CGSize)async -> UIImage?
    let loadImage: (_ assetId: String)async -> UIImage?
    let loadVideoPlayerItem: (_ assetId: String)async -> AVPlayerItem?
    
    @Environment(\.displayScale) private var displayScale
    var body: some View {
        GeometryReader {
            let screenSize = $0.size
            
            let pointSize = CGSize(
                width: (screenSize.width - 6) / 4,
                height: (screenSize.width - 6) / 4
            )

            let pixelSize = pointSize.scaled(
                by: displayScale
            )
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 2), count: 4), spacing: 2) {
                    ForEach(assets) { asset in
                    
                        MediaCellView(size: pointSize, asset: asset) {
                            await loadThumbnailIfNeed(asset.id, pixelSize)
                        }
                        .customContextMenu(actions: [], cornerRadius: 0) {
                            MediaPreview(asset: asset){
                                await loadImage(asset.id)
                            } loadVideoPlayerItem: {
                                await loadVideoPlayerItem(asset.id)
                            }
                        }
//                        .contextMenu {
//                            Button("Select") {
//                                
//                            }
//                        } preview: {
//                            MediaPreview(asset: asset){
//                                await loadImage(asset.id)
//                            } loadVideoPlayerItem: {
//                                await loadVideoPlayerItem(asset.id)
//                            }
//                        }

                    }
                }
                .padding(.vertical, AppSpacing.xxs)
            }
        }
    }
}
