//
//  CameraVideoRecordingDelegate.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import Foundation
@preconcurrency import AVFoundation

final class CameraVideoRecordingDelegate:
    NSObject,
    AVCaptureFileOutputRecordingDelegate {

    private let completion: @Sendable (Result<URL, Error>) -> Void

    nonisolated init(
        completion: @escaping @Sendable (Result<URL, Error>) -> Void
    ) {
        self.completion = completion
        super.init()
    }

    nonisolated func fileOutput(
        _ output: AVCaptureFileOutput,
        didFinishRecordingTo outputFileURL: URL,
        from connections: [AVCaptureConnection],
        error: Error?
    ) {

        if let error {
            completion(.failure(error))
            return
        }

        completion(.success(outputFileURL))
    }
}
