//
//  MediaLibraryRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import UIKit
import AVFoundation

protocol MediaLibraryRepository {

    func permissionStatus() -> MediaLibraryPermissionStatus

    func requestPermission() async throws -> MediaLibraryPermissionStatus

    func fetchAssets(limit: Int?) async throws -> [MediaAsset]

    func loadThumbnail(
        assetId: String,
        size: CGSize
    ) async throws -> UIImage?
    
    func loadImage(
        assetId: String,
    ) async throws -> UIImage?
    
    func loadVideoPlayerItem(
        assetId: String,
    ) async -> AVPlayerItem?

    func fetchAlbums() -> [MediaAlbum]
    
    func fetchAssets(albumId: String) async throws -> [MediaAsset]

}
