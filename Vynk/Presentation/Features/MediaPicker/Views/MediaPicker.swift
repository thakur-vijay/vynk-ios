//
//  MediaPicker.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

struct MediaPicker: View {
    @State private var viewModel: MediaPickerViewModel
    @State private var router: MediaRouter
    private let diContainer: MediaPickerDIContainer
    
    init(viewModel: MediaPickerViewModel, router: MediaRouter, diContaier: MediaPickerDIContainer) {
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
        self.diContainer = diContaier
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedType){
                MediaGridView(assets: viewModel.assets) { assetId, size in
                    await viewModel.loadThumbnailIfNeeded(assetId: assetId, size: size)
                } loadImage: { assetId in
                    await viewModel.loadImage(assetId: assetId)
                }
                .tag(MediaViewType.photos)
                .toolbarVisibility(.hidden, for: .tabBar)
                
                MediaAlbumListView(albums: viewModel.albums){ assetId, size in
                    await viewModel.loadThumbnailIfNeeded(assetId: assetId, size: size)
                }
                .tag(MediaViewType.albums)
                .toolbarVisibility(.hidden, for: .tabBar)

            }
            .tabViewStyle(.tabBarOnly)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Media")
            .toolbar {
                ToolbarCloseButton(placement: .topBarLeading) {
                    
                }
                
                ToolbarItem(placement: .principal) {
                    Picker("", selection: $viewModel.selectedType) {
                        ForEach(MediaViewType.allCases) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationDestination(for: MediaAlbum.self) { album in
                diContainer.makeAlbumDetailView(album: album)
            }

        }
        .task {
            await viewModel.loadMedia()
            viewModel.loadAlbums()
        }
    }
}

