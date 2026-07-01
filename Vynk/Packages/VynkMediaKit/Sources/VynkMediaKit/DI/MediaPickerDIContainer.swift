//
//  MediaPickerDIContainer.swift
//  VynkMediaKit
//
//  Created by Vijay Thakur on 01/07/26.
//


import Foundation

@available(iOS 18.0, *)
public final class MediaPickerDIContainer {
    
    public init() {
        
    }

    private lazy var dataSource = PhotoLibraryDataSource()

    private lazy var repository = DefaultMediaLibraryRepository(
        dataSource: dataSource
    )

    private lazy var permissionUseCase = MediaLibraryPermissionUseCase(
        repository: repository
    )

    private lazy var mediaLibraryUseCase = MediaLibraryUseCase(
        repository: repository
    )

    private lazy var thumbnailCache = MediaThumbnailCache()

    @MainActor func makeViewModel() -> MediaPickerViewModel {
        MediaPickerViewModel(
            permissionUseCase: permissionUseCase,
            mediaLibraryUseCase: mediaLibraryUseCase,
            thumbnailCache: thumbnailCache
        )
    }

    @MainActor func makeAlbumDetailView(
        album: MediaAlbum,
        result: @escaping (MediaModel)->()
    ) -> AlbumDetailView {
        AlbumDetailView(
            viewModel: makeAlbumDetailViewModel(album: album),
            result: result
        )
    }

    @MainActor func makeAlbumDetailViewModel(
        album: MediaAlbum
    ) -> AlbumDetailViewModel {
        AlbumDetailViewModel(
            mediaLibraryUseCase: mediaLibraryUseCase, album: album,
            thumbnailCache: thumbnailCache,
        )
    }

}

@available(iOS 18.0, *)
extension MediaPickerDIContainer: MediaProviding {
    @MainActor public func mediaHorizontalListView(
        result: @escaping (MediaModel?)->()
    ) -> MediaHorizontalListView {
        MediaHorizontalListView(
            viewModel: makeViewModel(),
            diContaier: self,
            result: result
        )
    }
    
    @MainActor public func mediaPermissionDeniedSheet(
        openSettings: @escaping ()->(),
        onClose: @escaping ()->()
    ) -> MediaPermissionDeniedSheet {
        MediaPermissionDeniedSheet(
            openSettings: openSettings,
            onClose: onClose
        )
    }
    
    
    @MainActor public func mediaPicker(result: @escaping (MediaModel?)->()) -> MediaPicker {
        MediaPicker(
            viewModel: makeViewModel(),
            router: MediaRouter(),
            diContaier: self,
            result: result
        )
    }
    
    public func isPhotoLibraryPermissionGiven()async throws-> Bool {
        let status = permissionUseCase.status()
        if status == .notDetermined {
            let newStatus = try await permissionUseCase.request()
            return newStatus == .authorized
        }else {
            return status == .authorized
        }
    }
}
