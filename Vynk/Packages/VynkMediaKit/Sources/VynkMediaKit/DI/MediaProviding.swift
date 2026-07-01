//
//  MediaProviding.swift
//  VynkMediaKit
//
//  Created by Vijay Thakur on 01/07/26.
//

import Foundation

@available(iOS 18.0, *)
public protocol MediaProviding {

    func isPhotoLibraryPermissionGiven() async throws -> Bool

    @MainActor
    func mediaPicker(result: @escaping (MediaModel?)->()) -> MediaPicker

    @MainActor
    func mediaPermissionDeniedSheet(
        openSettings: @escaping ()->(),
        onClose: @escaping ()->()
    ) -> MediaPermissionDeniedSheet

    @MainActor
    func mediaHorizontalListView(
        result: @escaping (MediaModel?)->()
    ) -> MediaHorizontalListView
}
