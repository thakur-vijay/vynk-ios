//
//  MediaAsset.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation

struct MediaAsset: Identifiable, Hashable {

    let id: String

    let mediaType: MediaType

    let duration: TimeInterval?

    let creationDate: Date?

}

enum MediaType {

    case image

    case video

}
