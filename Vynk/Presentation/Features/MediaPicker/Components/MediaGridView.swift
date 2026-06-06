//
//  MediaGridView.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

struct MediaGridView: View {
    let assets: [MediaAsset]
    let loadThumbnailIfNeed: (_ assetId: String, _ size: CGSize)async -> UIImage?
    let loadImage: (_ assetId: String)async -> UIImage?
    
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
                        MediaCellView(size: pointSize) {
                            await loadThumbnailIfNeed(asset.id, pixelSize)
                        }
                        .contextMenu {
                            Button("Select") {
                                
                            }
                        } preview: {
                            MediaPreview {
                                await loadImage(asset.id)
                            }
                        }

                    }
                }
                .padding(.vertical, AppSpacing.xxs)
            }
        }
    }
}
