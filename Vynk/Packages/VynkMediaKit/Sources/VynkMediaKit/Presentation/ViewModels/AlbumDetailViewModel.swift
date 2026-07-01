//
//  AlbumDetailViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation
import UIKit
import AVFoundation

@available(iOS 17.0, *)
@MainActor
@Observable
final class AlbumDetailViewModel {
    private let mediaLibraryUseCase: MediaLibraryUseCase
    private let thumbnailCache: MediaThumbnailCache
    
    init(mediaLibraryUseCase: MediaLibraryUseCase, album: MediaAlbum, thumbnailCache: MediaThumbnailCache) {
        self.mediaLibraryUseCase = mediaLibraryUseCase
        self.album = album
        self.thumbnailCache = thumbnailCache
    }
    
    deinit {
        print("AlbumDetailViewModel deinitialized")
    }
    
    var assets: [MediaModel] = []
    var album: MediaAlbum
    
    func loadThumbnailIfNeeded(assetId: String, size: CGSize) async-> UIImage?{
        if let cached = thumbnailCache.image(for: assetId, size: size) {
            return cached
        }
        
        do {
            if let image = try await mediaLibraryUseCase.fetchThumbnail(
                assetId: assetId,
                size: size
            ) {
                thumbnailCache.setImage(
                    image,
                    for: assetId,
                    size: size
                )
                return image
            }else {
                return nil
            }
            
        } catch {
            return nil
        }
        
    }
    
    func loadImage(assetId: String)async-> UIImage? {
       return try? await mediaLibraryUseCase.fetchImage(
            assetId: assetId,
        )
    }
    
    func loadVideoPlayerItem(assetId: String)async-> AVPlayerItem? {
       return await mediaLibraryUseCase.loadVideoPlayerItem(
            assetId: assetId,
        )
    }
    
    func loadMedia() async {
        do {
            
            assets = try await mediaLibraryUseCase.fetchAlbumAssets(albumId: album.id)
            print(assets.count)
        }catch {
            print(error.localizedDescription)
        }
    }
}
