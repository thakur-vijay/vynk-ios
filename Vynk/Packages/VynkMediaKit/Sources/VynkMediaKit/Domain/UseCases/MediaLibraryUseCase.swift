//
//  MediaLibraryUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation
import UIKit
import AVFoundation

final class MediaLibraryUseCase {
    private let repository: MediaLibraryRepository
    
    init(repository: MediaLibraryRepository) {
        self.repository = repository
    }
    
    func fetchMediaAlbums()-> [MediaAlbum] {
        return repository.fetchAlbums()
    }
    
    func fetchMediaAssets(limit: Int?)async throws ->[MediaModel] {
        let assets = try await repository.fetchAssets(limit: limit)
        return assets.compactMap { MediaAssetMapper.map($0)}
    }
    
    func fetchAlbumAssets(albumId: String)async throws ->[MediaModel] {
        let assets = try await repository.fetchAssets(albumId: albumId)
        return assets.compactMap { MediaAssetMapper.map($0) }
    }
    
    func fetchThumbnail(assetId: String, size: CGSize) async throws-> UIImage? {
        return try await repository.loadThumbnail(assetId: assetId, size: size)
    }
    
    func fetchImage(assetId: String) async throws-> UIImage? {
        return try await repository.loadImage(assetId: assetId)
    }
    
    func loadVideoPlayerItem(assetId: String) async -> AVPlayerItem? {
        return await repository.loadVideoPlayerItem(assetId: assetId)
    }
}
