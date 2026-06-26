//
//  VynkRemoteImageView.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import NukeUI
import SwiftUI
internal import Nuke

struct VynkRemoteImage<S: Shape>: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    let shape: S
    
    @Environment(\.displayScale) private var displayScale
    var body: some View {
        LazyImage(
            request: ImageRequest(
                url: url,
                processors: [ ImageProcessors.Resize(
                    size: CGSize(
                        width: width * displayScale,
                        height: height * displayScale
                    ),
                    contentMode: .aspectFill
                )]
            )
            
        ) { state in
            
            if let image = state.image {
                
                image
                
                    .resizable()
                
                    .scaledToFill()
                
            } else {
                
                AppColors.neutralSubtle
                
            }
            
        }
        .frame(width: width, height: height)
        .clipped()
        .clipShape(shape)
        .frame(width: width, height: height)
        .clipShape(shape)
    }
}
