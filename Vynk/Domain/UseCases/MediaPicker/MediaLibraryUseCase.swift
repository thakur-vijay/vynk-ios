//
//  MediaLibraryUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation
import UIKit

final class MediaLibraryUseCase {
    private let repository: MediaLibraryRepository
    
    init(repository: MediaLibraryRepository) {
        self.repository = repository
    }
    
    func fetchMediaAlbums()-> [MediaAlbum] {
        return repository.fetchAlbums()
    }
    
    func fetchMediaAssets()async throws ->[MediaAsset] {
        return try await repository.fetchAssets()
    }
    
    func fetchAlbumAssets(albumId: String)async throws ->[MediaAsset] {
        return try await repository.fetchAssets(albumId: albumId)
    }
    
    func fetchThumbnail(assetId: String, size: CGSize) async throws-> UIImage? {
        return try await repository.loadThumbnail(assetId: assetId, size: size)
    }
    
    func fetchImage(assetId: String) async throws-> UIImage? {
        return try await repository.loadImage(assetId: assetId)
    }
}
