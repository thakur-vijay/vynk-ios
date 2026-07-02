//
//  CameraDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
import VynkCameraKit
import VynkMediaKit

final class CameraDIContainer {
    private let cameraEngine: CameraEngine
    private let media: MediaPickerDIContainer
    
    init(
        cameraEngine: CameraEngine,
        media: MediaPickerDIContainer
    ) {
        self.cameraEngine = cameraEngine
        self.media = media
    }
    
    func makeView(onClose: @escaping ()->())-> CameraView {
        let repository = DefaultCameraRepository(engine: cameraEngine)
        let cameraSessionUseCase = CameraSessionUseCase(repository: repository)
        let viewModel = CameraViewModel(
            cameraSessionUseCase: cameraSessionUseCase,
            initialMode: .photo,
            initialPosition: .back,
            mediaProvider: media
        )
        return CameraView(
            viewModel: viewModel,
            diContainer: self,
            onClose: onClose
        )
    }
    
    func mediaPicker(result: @escaping (MediaModel?)->())-> MediaPicker {
        media.mediaPicker(result: result)
    }
    
    func mediaPermissionDeniedSheet(
        openSettings: @escaping ()->(),
        onClose: @escaping ()->()
    )-> MediaPermissionDeniedSheet {
        media.mediaPermissionDeniedSheet(
            openSettings: openSettings,
            onClose: onClose
        )
    }
    
    func mediaHorizontalListView(
        result: @escaping (MediaModel?)->(),
        openMediaPicker: @escaping ()->()
    )-> MediaHorizontalListView {
        media.mediaHorizontalListView(
            result: result,
            openMediaPicker: openMediaPicker
        )
    }
}
