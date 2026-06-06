//
//  AlbumDetailView.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

struct AlbumDetailView: View {
    @State private var viewModel: AlbumDetailViewModel
    
    init(viewModel: AlbumDetailViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        MediaGridView(assets: viewModel.assets) { assetId, size in
            await viewModel.loadThumbnailIfNeeded(assetId: assetId, size: size)
        } loadImage: { assetId in
            await viewModel.loadImage(assetId: assetId)
        }
        .navigationTitle(viewModel.album.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadMedia()
        }

    }
}
