//
//  MediaPickerViewModel.swift
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
    
    var assets: [MediaModel] = []
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
    
    func loadVideoPlayerItem(assetId: String)async-> AVPlayerItem? {
       return await mediaLibraryUseCase.loadVideoPlayerItem(
            assetId: assetId,
        )
    }
    
    func loadMedia(limit: Int? = nil) async {
        do {
            
            let status = permissionUseCase.status()
            switch status {
            case .notDetermined:
                let newStatus = try await permissionUseCase.request()
                if newStatus == .authorized || newStatus == .limited {
                    ///fetch
                    assets = try await mediaLibraryUseCase.fetchMediaAssets(limit: limit)
                }
            case .denied:
                print("Denied")
            case .restricted:
                print("restricted")
            case .authorized, .limited:
                assets = try await mediaLibraryUseCase.fetchMediaAssets(limit: limit)
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func loadAlbums(){
        albums = mediaLibraryUseCase.fetchMediaAlbums()
    }
}
