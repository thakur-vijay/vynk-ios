//
//  ScannerView.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import SwiftUI

struct ScannerView: View {
    let onDismiss: (ScannerResult)->()
    @State private var viewModel: ScannerViewModel
    
    init(viewModel: ScannerViewModel, onDismiss: @escaping (ScannerResult)->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        GeometryReader { proxy in
            CameraPreview(session: viewModel.session)
                .overlay {
                    ScannerOverlay(scannerSize: proxy.size.width - 70)
                }
                .overlay(alignment: .top) {
                    ScannerHeaderActions(
                        flashMode: viewModel.selectedFlashMode) {
                            onDismiss(.qrCode(""))
                        } onFlashModeTap: {
                            Task {
                                await viewModel.changeFlashMode()
                            }
                        }

                }
        }
        .background(AppColors.black)
        .task {
            viewModel.onScanCompleted = onDismiss
            await viewModel.prepareScanner()
        }
    }
}
