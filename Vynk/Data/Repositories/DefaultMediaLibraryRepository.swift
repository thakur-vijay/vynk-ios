//
//  DefaultMediaLibraryRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation
import UIKit
import AVFoundation

final class DefaultMediaLibraryRepository: MediaLibraryRepository {
    private let dataSource: PhotoLibraryDataSource
    
    init(dataSource: PhotoLibraryDataSource) {
        self.dataSource = dataSource
    }
    
    func permissionStatus() -> MediaLibraryPermissionStatus {
        return dataSource.permissionStatus()
    }

    func requestPermission() async throws -> MediaLibraryPermissionStatus {
        return try await dataSource.requestPermission()
    }

    func fetchAssets() async throws -> [MediaAsset] {
        return try await dataSource.fetchAssets()
    }
    
    func fetchAssets(albumId: String) async throws -> [MediaAsset] {
        return try await dataSource.fetchAssets(albumId: albumId)
    }

    func loadThumbnail(
        assetId: String,
        size: CGSize
    ) async throws -> UIImage? {
        return try await dataSource.loadThumbnail(assetId: assetId, size: size)
    }
    
    func loadImage(assetId: String) async throws -> UIImage? {
        return try await dataSource.loadImage(assetId: assetId)
    }
    
    func loadVideoPlayerItem(assetId: String) async -> AVPlayerItem? {
        return await dataSource.loadVideoPlayerItem(assetId: assetId)
    }
    
    func fetchAlbums() -> [MediaAlbum] {
        return dataSource.fetchAlbums()
    }

}
