//
//  MediaPickerViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation
import UIKit

@MainActor
@Observable
final class MediaPickerViewModel {
    
    private let permissionUseCase: MediaLibraryPermissionUseCase
    private let mediaLibraryUseCase: MediaLibraryUseCase
    private let thumbnailCache: MediaThumbnailCache
    
    init(
        permissionUseCase: MediaLibraryPermissionUseCase,
        mediaLibraryUseCase: MediaLibraryUseCase,
        thumbnailCache: MediaThumbnailCache
    ) {
        self.permissionUseCase = permissionUseCase
        self.mediaLibraryUseCase = mediaLibraryUseCase
        self.thumbnailCache = thumbnailCache
    }
    
    var assets: [MediaAsset] = []
    var albums: [MediaAlbum] = []
    var selectedType: MediaViewType = .photos
    
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
    
    func loadMedia() async {
        do {
            
            let status = permissionUseCase.status()
            AppLogger.debug(status, tag: String(describing: self))
            switch status {
            case .notDetermined:
                let newStatus = try await permissionUseCase.request()
                if newStatus == .authorized || newStatus == .limited {
                    ///fetch
                    assets = try await mediaLibraryUseCase.fetchMediaAssets()
                    AppLogger.debug(assets.count, tag: String(describing: self))
                }
            case .denied:
                AppLogger.error("denied", tag: String(describing: self))
            case .restricted:
                AppLogger.error("restricted", tag: String(describing: self))
            case .authorized, .limited:
                ///fetch
                assets = try await mediaLibraryUseCase.fetchMediaAssets()
                AppLogger.debug(assets.count, tag: String(describing: self))
            }
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
    
    func loadAlbums(){
        albums = mediaLibraryUseCase.fetchMediaAlbums()
        AppLogger.debug(albums.count, tag: "Albums length")
    }
}
