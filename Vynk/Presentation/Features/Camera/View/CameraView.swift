//
//  CameraView.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI
import MusicKit
import _AVKit_SwiftUI

struct CameraView: View {
    let onClose: ()->()
    @State private var viewModel: CameraViewModel
    
    @State private var player: AVPlayer = .init()
    init(viewModel: CameraViewModel, onClose: @escaping ()->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.onClose = onClose
    }
    
    var body: some View {
        NavigationStack {
            CameraPreview(session: viewModel.session)
                .ignoresSafeArea()
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            AppLogger.debug(value.magnification, "Magnification", tag: String(describing: self))
                            viewModel.updateZoomGesture(
                                scale: value.magnification
                            )
                        }
                        .onEnded { _ in
                            viewModel.endZoomGesture()
                        }
                )
                .onAppear {
                    viewModel.beginZoomGesture()
                }
                .overlay(alignment: .top){
                    CameraToolbar(
                        flashMode: viewModel.selectedFlashMode,
                        mode: viewModel.selectedMode,
                        isRecording: viewModel.isRecordingVideo,
                        time: viewModel.recordingDuration,
                        onClose: onClose
                    ) {
                        viewModel.toggleFlashMode()
                    }
                }
                .overlay(alignment: .bottom) {
                    VStack(spacing: AppSpacing.lg){
                        CameraActionsView(
                            mode: viewModel.selectedMode,
                            position: viewModel.selectedPosition,
                            isCaptureDisabled: viewModel.isCapturingPhoto,
                            isRecording: viewModel.isRecordingVideo,
                            zoomFactor: viewModel.zoomFactor
                        ) {
                            Task {
                                await viewModel.capture()
                            }
                        } onSwitch: {
                            Task {
                                await viewModel
                                    .switchCamera()
                            }
                        } onPhotosTap: {
                            ///open media picker
                        } onFilterTap: {
                            
                        } onZoomTap: {
                            Task {
                                let zoomPreset: CameraZoomPreset = viewModel.selectedZoomPreset == .pointFive ? .one : .pointFive
                                await viewModel.selectZoomPreset(zoomPreset)
                            }
                        }
                        
                        GlassSegmentedControl(selection: $viewModel.activeIndex, tabs: $viewModel.tabs)
                            .onChange(of: viewModel.activeIndex) { oldValue, newValue in
                                Task {
                                    await viewModel.switchMode()
                                }
                            }
                            .opacity(viewModel.isRecordingVideo ? 0 : 1)
                            .allowsHitTesting(!viewModel.isRecordingVideo)
                    }
                }
                .background(.black)
                .animation(.smooth, value: viewModel.isRecordingVideo)
                .task {
                    await viewModel.prepareCamera()
                }
                .navigationDestination(item: $viewModel.capturedOutput) { output in
                    switch output {
                    case .photo(let image):
                        GeometryReader { proxy in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(
                                    width: proxy.size.width,
                                    height: proxy.size.height
                                )
                                .background(.black)
                        }
                        .ignoresSafeArea()
                    case .video(let url): VideoPlayer(player: player).task {
                        player = .init(url: url)
                        player.play()
                    }
                    }
                }
        }
    }
}

struct PanGesture: UIGestureRecognizerRepresentable {

    var onChanged: (CGPoint) -> Void
    var onEnded: () -> Void

    func makeCoordinator(
        converter: CoordinateSpaceConverter
    ) -> Coordinator {
        Coordinator(
            onChanged: onChanged,
            onEnded: onEnded
        )
    }

    func makeUIGestureRecognizer(
        context: Context
    ) -> UIPanGestureRecognizer {

        let recognizer = UIPanGestureRecognizer(
            target: context.coordinator,
            action: #selector(
                Coordinator.handlePan(_:))
        )

        return recognizer
    }

    func updateUIGestureRecognizer(
        _ recognizer: UIPanGestureRecognizer,
        context: Context
    ) {

    }
}

extension PanGesture {

    final class Coordinator: NSObject {

        private let onChanged: (CGPoint) -> Void
        private let onEnded: () -> Void

        init(
            onChanged: @escaping (CGPoint) -> Void,
            onEnded: @escaping () -> Void
        ) {
            self.onChanged = onChanged
            self.onEnded = onEnded
        }

        @objc
        func handlePan(
            _ gesture: UIPanGestureRecognizer
        ) {

            let translation =
                gesture.translation(
                    in: gesture.view
                )

            switch gesture.state {

            case .changed:

                onChanged(translation)

            case .ended,
                 .cancelled,
                 .failed:

                onEnded()

            default:
                break
            }
        }
    }
}
