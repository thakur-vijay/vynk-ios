//
//  CameraSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/07/26.
//

import Foundation

enum CameraSheet: Identifiable {
    case mediaPicker
    case mediaPermissionDenied

    var id: Self { self }
}
