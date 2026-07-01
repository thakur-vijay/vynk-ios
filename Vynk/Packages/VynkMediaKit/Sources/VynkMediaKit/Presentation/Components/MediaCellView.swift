//
//  MediaCellView.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

@available(iOS 16.0, *)
struct MediaCellView: View {
    let size: CGSize
    var asset: MediaModel?
    var cornerRadius: CGFloat = 0
    let loadThumbnail: ()async-> UIImage?
    
    @State private var thumbnail: UIImage?

    var body: some View {
        Rectangle()
            .fill(.gray.opacity(0.15))
            .frame(width: size.width, height: size.height)
            .overlay {
                if let thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .overlay(alignment: .bottom){
                            if let asset, asset.mediaType == .video {
                                HStack {
                                    Image(systemName: "video.fill")
                                        Spacer()
                                    Text(asset.duration)
                                }
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.background)
                                .padding(10)
                                .frame(maxHeight: .infinity, alignment: .bottom)
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
