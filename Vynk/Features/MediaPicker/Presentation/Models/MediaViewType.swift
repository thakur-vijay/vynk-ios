//
//  MediaViewType.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation

enum MediaViewType: String, CaseIterable, Identifiable{
    case photos = "Photos"
    case albums = "Albums"
    
    var id: String { rawValue }

}
