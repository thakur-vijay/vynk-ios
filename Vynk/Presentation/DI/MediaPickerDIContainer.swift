//
//  MediaPickerDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation

final class MediaPickerDIContainer {

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

    func makeView() -> MediaPicker {
        MediaPicker(
            viewModel: makeViewModel(),
            router: MediaRouter(),
            diContaier: self
        )
    }

    func makeViewModel() -> MediaPickerViewModel {
        MediaPickerViewModel(
            permissionUseCase: permissionUseCase,
            mediaLibraryUseCase: mediaLibraryUseCase,
            thumbnailCache: thumbnailCache
        )
    }

    func makeAlbumDetailView(
        album: MediaAlbum
    ) -> AlbumDetailView {
        AlbumDetailView(
            viewModel: makeAlbumDetailViewModel(album: album)
        )
    }

    func makeAlbumDetailViewModel(
        album: MediaAlbum
    ) -> AlbumDetailViewModel {
        AlbumDetailViewModel(
            mediaLibraryUseCase: mediaLibraryUseCase, album: album,
            thumbnailCache: thumbnailCache,
        )
    }
}
