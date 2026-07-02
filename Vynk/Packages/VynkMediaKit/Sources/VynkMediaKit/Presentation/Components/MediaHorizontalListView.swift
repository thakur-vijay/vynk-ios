//
//  File.swift
//  VynkMediaKit
//
//  Created by Vijay Thakur on 01/07/26.
//

import SwiftUI
import VynkDesignSystem

@available(iOS 18.0, *)
public struct MediaHorizontalListView: View {
    @State private var viewModel: MediaPickerViewModel
    private let diContainer: MediaPickerDIContainer
    let result: (MediaModel?)->()
    let openMediaPicker: ()->()
    
    init(
        viewModel: MediaPickerViewModel,
        diContaier: MediaPickerDIContainer,
        result: @escaping (MediaModel?)->(),
        openMediaPicker: @escaping ()->()
    ){
        _viewModel = State(wrappedValue: viewModel)
        self.diContainer = diContaier
        self.result = result
        self.openMediaPicker = openMediaPicker
    }
    
    public var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView(.horizontal){
                LazyHStack(spacing: 4) {
                    ForEach(viewModel.assets) { asset in
                        MediaCellView(
                            size: .init(width: size.height, height: size.height),
                            asset: asset,
                            cornerRadius: 0) {
                                await viewModel.loadThumbnailIfNeeded(
                                    assetId: asset.id,
                                    size: .init(width: size.height, height: size.height)
                                )
                            }
                            .contentShape(.rect)
                            .onTapGesture {
                                result(asset)
                            }
                    }
                    Rectangle()
                        .fill(AppColors.secondarySurface)
                        .frame(width: size.height, height: size.height)
                        .overlay {
                            AppSymbols.photo.image
                                .font(AppFont.title3)
                                .foregroundStyle(.white)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            openMediaPicker()
                        }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .frame(height: 100)
        .task {
            await viewModel.loadMedia(limit: 40)
        }
    }
}

