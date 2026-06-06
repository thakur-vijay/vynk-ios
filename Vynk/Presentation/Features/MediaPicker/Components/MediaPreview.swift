//
//  MediaPreview.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import SwiftUI

struct MediaPreview: View {
    let loadImage: ()async-> UIImage?
    
    @State private var thumbnail: UIImage?

    var body: some View {
        Group {
            if let thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: AppRadius.lg, style: .continuous))
                    .contentShape(.rect)
            }
        }
        .task {
            thumbnail = await loadImage()
        }
    }
}
