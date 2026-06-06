//
//  MediaModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation

struct MediaModel: Identifiable, Hashable {

    let id: String

    let mediaType: MediaType

    let duration: String

    let creationDate: Date
    
    let pixelWidth: Int
    
    let pixelHeight: Int
    
    let previewSize: CGSize

}
