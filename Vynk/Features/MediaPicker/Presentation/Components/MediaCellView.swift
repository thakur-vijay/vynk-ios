//
//  MediaCellView.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

struct MediaCellView: View {
    let size: CGSize
    var asset: MediaModel?
    var cornerRadius: CGFloat = 0
    let loadThumbnail: ()async-> UIImage?
    
    @State private var thumbnail: UIImage?

    var body: some View {
        Rectangle()
            .fill(AppColors.backgroundSecondary)
            .frame(size)
            .overlay {
                if let thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(size)
                        .overlay(alignment: .bottom){
                            if let asset, asset.mediaType == .video {
                                HStack {
                                    Image(systemName: AppIcons.videoFill)
                                        Spacer()
                                    Text(asset.duration)
                                }
                                .font(AppFont.captionSemibold)
                                .foregroundStyle(AppColors.white)
                                .padding(AppSpacing.sm)
                                .vSpacing(.bottom)
                                .background {
                                    LinearGradient(colors: [
                                        .black,
                                        .black.opacity(0.5),
                                        .black.opacity(0.3),
                                        .black.opacity(0.1)
                                    ], startPoint: .bottom, endPoint: .top)
                                }
                            }
                        }
                        .clipShape(.rect(cornerRadius: cornerRadius, style: .continuous))
                        .contentShape(.rect)
                }
            }
            .task {
               thumbnail = await loadThumbnail()
            }
    }
}
