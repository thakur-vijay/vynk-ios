//
//  PhotoLibraryDataSource.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import UIKit
import Foundation
import Photos
import AVFoundation

final class PhotoLibraryDataSource {
    
    private let imageManager = PHCachingImageManager()
    
    func permissionStatus() -> MediaLibraryPermissionStatus {
        return Self.mapAuthorizationStatus(PHPhotoLibrary.authorizationStatus(for: .readWrite))
    }

    func requestPermission() async throws -> MediaLibraryPermissionStatus {
        return await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                continuation.resume(
                    returning: Self.mapAuthorizationStatus(status)
                )
            }
        }
    }

    func fetchAssets(limit: Int? = nil) async throws -> [MediaAsset] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false
            )
        ]

        let result = PHAsset.fetchAssets(with: fetchOptions)

        let count = min(limit ?? result.count, result.count)

        var assets: [MediaAsset] = []
        assets.reserveCapacity(count)

        for index in 0..<count {
            let asset = result.object(at: index)

            guard let mediaType = Self.mapMediaType(asset.mediaType) else {
                continue
            }

            assets.append(
                MediaAsset(
                    id: asset.localIdentifier,
                    mediaType: mediaType,
                    duration: asset.mediaType == .video ? asset.duration : nil,
                    creationDate: asset.creationDate,
                    pixelWidth: asset.pixelWidth,
                    pixelHeight: asset.pixelHeight
                )
            )
        }

        return assets
    }

    func loadThumbnail(
        assetId: String,
        size: CGSize,
    ) async throws -> UIImage? {
        
        guard let asset = fetchAsset(id: assetId) else {
            return nil
        }
        
        return await withCheckedContinuation { continuation in

            let options = PHImageRequestOptions()

            options.deliveryMode = .highQualityFormat

            options.resizeMode = .exact

            options.isNetworkAccessAllowed = true

            options.isSynchronous = false

            imageManager.requestImage(

                for: asset,

                targetSize: size,

                contentMode: .aspectFill,

                options: options

            ) { image, _ in

                continuation.resume(returning: image)

            }
            
        }
        
    }
    
    func loadImage(assetId: String) async throws -> UIImage? {
        guard let asset = fetchAsset(id: assetId) else {
            return nil
        }
        
        return await withCheckedContinuation { continuation in
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .none
            options.isNetworkAccessAllowed = true
            options.isSynchronous = false
            imageManager.requestImage(
                for: asset,
                targetSize: PHImageManagerMaximumSize,
                contentMode: .aspectFit,
                options: options
            ) { image, _ in
                continuation.resume(returning: image)
            }
            
        }
        
    }

    func loadVideoPlayerItem(assetId: String) async -> AVPlayerItem? {
        guard let asset = fetchAsset(id: assetId),
              asset.mediaType == .video else {
            return nil
        }

        return await withCheckedContinuation { continuation in
            let options = PHVideoRequestOptions()
            options.deliveryMode = .automatic
            options.isNetworkAccessAllowed = true

            imageManager.requestPlayerItem(
                forVideo: asset,
                options: options
            ) { playerItem, info in
                if let error = info?[PHImageErrorKey] as? Error {
                    print(error.localizedDescription, "VideoPreview")
                    continuation.resume(returning: nil)
                    return
                }

                continuation.resume(returning: playerItem)
            }
        }
    }
    
    func fetchAlbums() -> [MediaAlbum] {

        var albums: [MediaAlbum] = []

        let fetchOptions = PHFetchOptions()

        // Smart Albums
        let smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .any,
            options: nil
        )

        smartAlbums.enumerateObjects { collection, _, _ in

            let assets = PHAsset.fetchAssets(
                in: collection,
                options: fetchOptions
            )

            guard assets.count > 0 else {
                return
            }

            albums.append(
                MediaAlbum(
                    id: collection.localIdentifier,
                    title: collection.localizedTitle ?? "Untitled",
                    assetCount: assets.count,
                    coverAssetId: assets.lastObject?.localIdentifier
                )
            )
        }

        // User Albums
        let userAlbums = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: nil
        )

        userAlbums.enumerateObjects { collection, _, _ in

            let assets = PHAsset.fetchAssets(
                in: collection,
                options: fetchOptions
            )

            guard assets.count > 0 else {
                return
            }

            albums.append(
                MediaAlbum(
                    id: collection.localIdentifier,
                    title: collection.localizedTitle ?? "Untitled",
                    assetCount: assets.count,
                    coverAssetId: assets.firstObject?.localIdentifier
                )
            )
        }

        return albums.sorted {
            $0.title.localizedCaseInsensitiveCompare(
                $1.title
            ) == .orderedAscending
        }
    }
    
    func fetchAssets(albumId: String) async throws -> [MediaAsset] {
        guard let collection = fetchAlbum(id: albumId) else {
            return []
        }

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false
            )
        ]

        let result = PHAsset.fetchAssets(
            in: collection,
            options: fetchOptions
        )

        var assets: [MediaAsset] = []

        result.enumerateObjects { asset, _, _ in
            guard let mediaType = Self.mapMediaType(asset.mediaType) else {
                return
            }

            assets.append(
                MediaAsset(
                    id: asset.localIdentifier,
                    mediaType: mediaType,
                    duration: asset.mediaType == .video ? asset.duration : nil,
                    creationDate: asset.creationDate,
                    pixelWidth: asset.pixelWidth,
                    pixelHeight: asset.pixelHeight
                )
            )
        }

        return assets
    }
}

fileprivate extension PhotoLibraryDataSource {
    private func fetchAsset(id: String) -> PHAsset? {
           let result = PHAsset.fetchAssets(
               withLocalIdentifiers: [id],
               options: nil
           )

           return result.firstObject

       }
    
    private func fetchAlbum(id: String) -> PHAssetCollection? {

        let collections = PHAssetCollection.fetchAssetCollections(

            withLocalIdentifiers: [id],

            options: nil

        )

        return collections.firstObject

    }
    
    nonisolated private static func mapAuthorizationStatus(
        _ status: PHAuthorizationStatus
    ) -> MediaLibraryPermissionStatus {
        
        switch status {
            
        case .notDetermined:
            
            return .notDetermined
            
        case .restricted:
            
            return .restricted
            
        case .denied:
            
            return .denied
            
        case .authorized:
            
            return .authorized
            
        case .limited:
            
            return .limited
            
        @unknown default:
            
            return .denied
            
        }
        
    }
    
    nonisolated private static func mapMediaType(
           _ type: PHAssetMediaType
       ) -> MediaType? {

           switch type {

           case .image:

               return .image

           case .video:

               return .video

           default:

               return nil

           }

       }
}
