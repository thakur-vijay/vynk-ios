//
//  CameraDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation
import VynkCameraKit

final class CameraDIContainer {
    private let cameraEngine: CameraEngine
    
    init(cameraEngine: CameraEngine) {
        self.cameraEngine = cameraEngine
    }
    
    func makeView(onClose: @escaping ()->())-> CameraView {
        let repository = DefaultCameraRepository(engine: cameraEngine)
        let cameraSessionUseCase = CameraSessionUseCase(repository: repository)
        let viewModel = CameraViewModel(
            cameraSessionUseCase: cameraSessionUseCase,
            initialMode: .photo,
            initialPosition: .back
        )
        return CameraView(viewModel: viewModel, onClose: onClose)
    }
}
