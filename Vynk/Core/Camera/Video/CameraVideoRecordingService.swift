//
//  CameraVideoRecordingService.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import AVFoundation
import Foundation

final class CameraVideoRecordingService {

    private let movieOutput = AVCaptureMovieFileOutput()

    private var videoDelegate: CameraVideoRecordingDelegate?
    private var videoContinuation: CheckedContinuation<CameraOutput, Error>?
    private var recordingURL: URL?
    private var isRecordingVideo = false

    private let sessionManager: CameraSessionManager

    init(sessionManager: CameraSessionManager) {
        self.sessionManager = sessionManager
    }

    func attachOutput() throws {
        try sessionManager.addOutput(movieOutput)
    }

    func detachOutput() {
        sessionManager.removeOutput(movieOutput)
    }

    func startRecording() throws {
        guard !isRecordingVideo else {
            throw CameraVideoRecordingError.recordingInProgress
        }

        guard !movieOutput.isRecording else {
            throw CameraVideoRecordingError.recordingInProgress
        }

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("mov")

        let delegate = CameraVideoRecordingDelegate { [weak self] result in
            Task {
                await self?.finishVideoRecording(result)
            }
        }

        videoDelegate = delegate
        recordingURL = url
        isRecordingVideo = true

        movieOutput.startRecording(
            to: url,
            recordingDelegate: delegate
        )
    }

    func stopRecording() async throws -> CameraOutput {
        guard isRecordingVideo else {
            throw CameraVideoRecordingError.notRecording
        }

        guard movieOutput.isRecording else {
            throw CameraVideoRecordingError.notRecording
        }

        return try await withCheckedThrowingContinuation { continuation in
            videoContinuation = continuation
            movieOutput.stopRecording()
        }
    }

    private func finishVideoRecording(
        _ result: Result<URL, Error>
    ) {
        let continuation = videoContinuation

        videoContinuation = nil
        videoDelegate = nil
        recordingURL = nil
        isRecordingVideo = false

        switch result {
        case .success(let url):
            continuation?.resume(
                returning: .video(url)
            )

        case .failure(let error):
            continuation?.resume(
                throwing: error
            )
        }
    }
}

enum CameraVideoRecordingError: Error {
    case recordingInProgress
    case notRecording
}
