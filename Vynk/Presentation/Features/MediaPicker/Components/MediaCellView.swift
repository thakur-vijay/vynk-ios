//
//  MediaCellView.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

struct MediaCellView: View {
    let size: CGSize
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
                        .clipShape(.rect(cornerRadius: cornerRadius, style: .continuous))
                        .contentShape(.rect)
                }
            }
            .task {
               thumbnail = await loadThumbnail()
            }
    }
}
