//
//  MediaAlbum.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation

struct MediaAlbum: Identifiable, Hashable {

    let id: String

    let title: String

    let assetCount: Int

    let coverAssetId: String?

}
