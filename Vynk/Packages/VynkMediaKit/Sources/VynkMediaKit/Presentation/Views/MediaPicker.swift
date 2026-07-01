//
//  MediaPicker.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

@available(iOS 18.0, *)
public struct MediaPicker: View {
    @State private var viewModel: MediaPickerViewModel
    @State private var router: MediaRouter
    private let diContainer: MediaPickerDIContainer
    let result: (MediaModel?)->()
    
    init(
        viewModel: MediaPickerViewModel,
        router: MediaRouter,
        diContaier: MediaPickerDIContainer,
        result: @escaping (MediaModel?)->()
    ){
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
        self.diContainer = diContaier
        self.result = result
    }
    
    public init(result: @escaping (MediaModel?)->()){
        self.diContainer = .init()
        let viewModel = self.diContainer.makeViewModel()
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: MediaRouter())
        self.result = result
    }
    
    public var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedType){
                MediaGridView(assets: viewModel.assets) { assetId, size in
                    await viewModel.loadThumbnailIfNeeded(assetId: assetId, size: size)
                } loadImage: { assetId in
                    await viewModel.loadImage(assetId: assetId)
                } loadVideoPlayerItem: { assetId in
                    await viewModel.loadVideoPlayerItem(assetId: assetId)
                } result: { model in
                    result(model)
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
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: "xmark"){
                        result(nil)
                    }
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
                diContainer.makeAlbumDetailView(album: album){ model in
                    result(model)
                }
            }

        }
        .task {
            await viewModel.loadMedia()
            viewModel.loadAlbums()
        }
    }
}

