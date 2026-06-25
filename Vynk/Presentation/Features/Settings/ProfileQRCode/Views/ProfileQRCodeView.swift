//
//  ProfileQRCodeView.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI

struct ProfileQRCodeView: View {
    @State private var viewModel: ProfileQRCodeViewModel
    @State private var router: ProfileQRCodeRouter
    private let diContainer: ProfileQRCodeDIContainer
    
    init(
        viewModel: ProfileQRCodeViewModel,
        router: ProfileQRCodeRouter,
        diContainer: ProfileQRCodeDIContainer
    ) {
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
        self.diContainer = diContainer
    }
    
    @Environment(\.scenePhase) private var phase
    
    var body: some View {
        VStack{
            UserQRCardView(qrContent: viewModel.qrContent)
            Spacer()
            QRCodeActions {
                router.presentFullScreenCover(.scanner)
            } resetCode: {
                viewModel.resetQRCode()
            }

        }
        .hSpacing()
        .vSpacing()
        .padding(.horizontal, AppSpacing.xxxlg)
        .padding(.vertical, AppSpacing.xlg)
        .background(AppColors.backgroundSecondary)
        .navigationTitle("QR Code")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ShareQRToolbar {
                
            }
        }
        .task(viewModel.setFullBrightness)
        .onDisappear(perform: viewModel.restoreBrightness)
        .onChange(of: phase) { oldValue, newValue in
            viewModel.handleSceneBrightness(for: newValue)
        }
        .fullScreenCover(item: $router.activeFullScreenCover) { fullScreenCover in
            switch fullScreenCover {
            case .scanner:
                diContainer.makeScannerSheet { result in
                    switch result {
                    case .qrCode(let value):
                        if value.isEmpty {
                            ///present alert
                        }else {
                            ///look up for user
                            ///if found, dismiss scanner
                            let isContactSaved = true
                            if isContactSaved {
                                router.dismissSheet()
                                Task {
                                    await viewModel.didScanUser()
                                }
                            }else {
                                router.presentSheet(.addToContacts)
                            }
                        }
                    }
                }
                .sheet(item: $router.activeSheet) { sheet in
                    switch sheet {
                    case .addToContacts: Text("")
                            .presentationDetents([.medium])
                    }
                }
    
            }
        }
    }
}
