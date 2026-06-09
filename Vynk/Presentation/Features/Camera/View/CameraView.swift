//
//  CameraView.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI
import MusicKit

struct CameraView: View {
    let onClose: ()->()
    @State private var viewModel: CameraViewModel
    
    init(viewModel: CameraViewModel, onClose: @escaping ()->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.onClose = onClose
    }
    
    var body: some View {
        NavigationStack {
            CameraPreviewView(session: viewModel.session)
                .ignoresSafeArea()
                .overlay(alignment: .top){
                    CameraToolbar(flashMode: viewModel.selectedFlashMode, onClose: onClose) {
                        viewModel.toggleFlashMode()
                    }
                }
                .overlay(alignment: .bottom) {
                    VStack(spacing: AppSpacing.lg){
                        CameraActionsView(mode: viewModel.selectedMode, isCaptureDisabled: viewModel.isCapturingPhoto) {
                            Task {
                                await viewModel.capturePhoto()
                            }
                        } onSwitch: {
                            Task {
                                await viewModel.switchCamera()
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
                    }
                }
            .background(.black)
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
                case .video(_): Text("Video preview")
                }
            }
        }
    }
}
