//
//  ScannerView.swift
//  VynkScannerKit
//
//  Created by Vijay Thakur on 25/07/26.
//


import SwiftUI
import VynkCameraKit
import ComposableArchitecture
import VynkDesignSystem

public struct ScannerView: View {
    let store: StoreOf<ScannerFeature>
    
    public init(store: StoreOf<ScannerFeature>) {
        self.store = store
    }
    
    public var body: some View {
        GeometryReader { proxy in
            CameraPreview(session: store.session)
                .overlay {
                    ScannerOverlay(scannerSize: proxy.size.width - 70)
                }
                .overlay(alignment: .top) {
                    ScannerHeaderActions(
                        flashMode: store.flashMode) {
                            store.send(.closeTapped)
                        } onFlashModeTap: {
                            store.send(.flashTapped)
                        }

                }
        }
        .background(AppColors.black)
        .task {
            await store.send(.task).finish()
        }
    }
}
