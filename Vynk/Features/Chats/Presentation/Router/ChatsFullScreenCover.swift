//
//  ChatsFullScreenCover.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation

enum ChatsFullScreenCover: Identifiable {
    case camera

    var id: String {
        switch self {
        case .camera: "camera"
        }
    }
}
