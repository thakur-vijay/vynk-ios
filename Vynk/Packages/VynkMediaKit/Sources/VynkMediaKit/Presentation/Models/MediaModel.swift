//
//  MediaModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation

public struct MediaModel: Identifiable, Hashable {

    public let id: String

    public let mediaType: MediaType

    public let duration: String

    public let creationDate: Date
    
    public let pixelWidth: Int
    
    public let pixelHeight: Int
    
    public let previewSize: CGSize

}
