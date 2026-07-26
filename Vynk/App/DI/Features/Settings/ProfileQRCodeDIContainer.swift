//
//  ProfileQRCodeDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

//import VynkCameraKit
//
//final class ProfileQRCodeDIContainer {
//    private let screenBrightnessManager: ScreenBrightnessManaging
//    private let chatNavigator: ChatNavigator
////    private let makeScannerView: (@escaping (ScannerResult) -> Void) -> ScannerView
//    
//    init(
//        screenBrightnessManager: ScreenBrightnessManaging,
//        chatNavigator: ChatNavigator,
////        makeScannerView: @escaping (@escaping (ScannerResult) -> Void) -> ScannerView
//    ) {
//        self.screenBrightnessManager = screenBrightnessManager
////        self.makeScannerView = makeScannerView
//        self.chatNavigator = chatNavigator
//    }
//    
//    func makeProfileQRCodeView()-> ProfileQRCodeView {
//        let viewModel = ProfileQRCodeViewModel(
//            brightnessManager: screenBrightnessManager,
//            chatNavigator: chatNavigator
//        )
//        let router = ProfileQRCodeRouter()
//        return ProfileQRCodeView(
//            viewModel: viewModel,
//            router: router,
//            diContainer: self
//        )
//    }
////    
////    func makeScannerSheet(result: @escaping (ScannerResult) -> Void)-> ScannerView {
//////        makeScannerView(result)
////    }
//}
