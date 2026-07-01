//
//  MediaPreview.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI

struct MediaPreview: View {
    let asset: MediaModel
    let loadImage: ()async-> UIImage?
    let loadVideoPlayerItem: () async -> AVPlayerItem?
    
    @State private var thumbnail: UIImage?
    @State private var player: AVPlayer?
    
    var body: some View {
        Group {
            switch asset.mediaType {
            case .image:
                if let thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .scaledToFit()
                }
            case .video:
                if let player {
                    VideoPlayer(player: player)
                        .aspectRatio(CGFloat(asset.pixelWidth) / CGFloat(asset.pixelHeight), contentMode: .fit)
                        .onAppear {
                            player.play()
                        }
                        .onDisappear {
                            player.pause()
                        }
                } else {
                    ProgressView()
                }
                
            }
        }
        .frame(width: asset.previewSize.width, height: asset.previewSize.height)
        .clipShape(.rect(cornerRadius: 18, style: .continuous))
        .task {
            switch asset.mediaType {
            case .image:
                thumbnail = await loadImage()
            case .video:
                if let item = await loadVideoPlayerItem() {
                    player = AVPlayer(playerItem: item)
                }
            }
        }
        .onDisappear {
            player?.pause()
            player?.replaceCurrentItem(with: nil)
            player = nil
        }
    }
}
