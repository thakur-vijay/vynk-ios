//
//  SwiftUIView.swift
//  VynkQRCodeKit
//
//  Created by Vijay Thakur on 18/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

public struct ProfileQRCodeView: View {
    let store: StoreOf<ProfileQRCodeFeature>
    
    public init(store: StoreOf<ProfileQRCodeFeature>) {
        self.store = store
    }
    
    @Environment(\.scenePhase) private var phase
    @Dependency(\.screenBrightness)
    var brightness
    
    public var body: some View {
        VStack{
            UserQRCardView(qrContent: store.qrContent)
            Spacer()
            QRCodeActions {
                store.send(.scanTapped)
            } resetCode: {
                store.send(.resetQRCodeTapped)
            }

        }
        .fillWidth()
        .fillHeight()
        .padding(.horizontal, AppSpacing.xxxl)
        .padding(.vertical, AppSpacing.xl)
        .background(AppColors.backgroundSecondary)
        .navigationTitle("QR Code")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("", systemImage: AppSymbols.Share.share.name){
                    store.send(.shareTapped)
                }
            }
        }
        .task {
            brightness.setBrightness(.maximum)
        }
        .onDisappear {
            brightness.restoreBrightness()
        }
        .onChange(of: phase) { oldValue, newValue in
            switch newValue {
            case .active: brightness.setBrightness(.maximum)
            default: brightness.restoreBrightness()
            }
        }
    }
}
