//
//  AlbumDetailView.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

@available(iOS 17.0, *)
struct AlbumDetailView: View {
    @State private var viewModel: AlbumDetailViewModel
    let result: (MediaModel)->()
    
    init(viewModel: AlbumDetailViewModel, result: @escaping (MediaModel)->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.result = result
    }
    
    var body: some View {
        MediaGridView(assets: viewModel.assets) { assetId, size in
            await viewModel.loadThumbnailIfNeeded(assetId: assetId, size: size)
        } loadImage: { assetId in
            await viewModel.loadImage(assetId: assetId)
        } loadVideoPlayerItem: { assetId in
            await viewModel.loadVideoPlayerItem(assetId: assetId)
        } result: { model in
            result(model)
        }
        .navigationTitle(viewModel.album.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadMedia()
        }

    }
}
