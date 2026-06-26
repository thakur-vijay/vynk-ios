//
//  CameraPhotoCaptureDelegate.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import UIKit
@preconcurrency import AVFoundation

@available(iOS 17.0, *)
public final class CameraPhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {

    private let completion: (Result<UIImage, Error>) -> Void

    nonisolated init(
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        self.completion = completion
        super.init()
    }

    nonisolated public func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        if let error {
            completion(.failure(error))
            return
        }

        guard let data = photo.fileDataRepresentation() else {
            completion(
                .failure(CameraEngine.CameraDataSourceError.photoDataMissing)
            )
            return
        }

        guard let image = UIImage(data: data) else {
            completion(
                .failure(CameraEngine.CameraDataSourceError.invalidPhotoData)
            )
            return
        }

        completion(.success(image))
    }
}
