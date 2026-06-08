//
//  CameraDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import Foundation

final class CameraDIContainer {
    
    func makeView(onClose: @escaping ()->())-> CameraView {
        let dataSource = CameraDataSource()
        let repository = DefaultCameraRepository(dataSource: dataSource)
        let cameraSessionUseCase = CameraSessionUseCase(repository: repository)
        let viewModel = CameraViewModel(
            cameraSessionUseCase: cameraSessionUseCase,
            initialMode: .photo,
            initialPosition: .back
        )
        return CameraView(viewModel: viewModel, onClose: onClose)
    }
}
