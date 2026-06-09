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
            CameraPreviewView(session: viewModel.session)
                .ignoresSafeArea()
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
                            isRecording: viewModel.isRecordingVideo
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
