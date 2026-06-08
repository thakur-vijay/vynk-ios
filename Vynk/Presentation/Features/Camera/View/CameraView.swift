//
//  CameraView.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI

struct CameraView: View {
    let onClose: ()->()
    @State private var viewModel: CameraViewModel
    
    init(viewModel: CameraViewModel, onClose: @escaping ()->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.onClose = onClose
    }
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            CameraPreviewView(session: viewModel.session)
            .ignoresSafeArea()
            .overlay(alignment: .top){
                CameraToolbar(onClose: onClose) {
                    
                }
            }
            .overlay(alignment: .bottom) {
                CameraActionsView()
                    .padding(.bottom, safeArea.bottom + AppSpacing.md)
            }
        }
        .task {
            await viewModel.prepareCamera()
        }
    }
}

