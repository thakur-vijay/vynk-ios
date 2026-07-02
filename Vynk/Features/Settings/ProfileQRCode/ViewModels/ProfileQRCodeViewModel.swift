//
//  ProfileQRCodeViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/06/26.
//

import SwiftUI
import VynkFoundation

@LifecycleLogged
@MainActor
@Observable
final class ProfileQRCodeViewModel {
    private let brightnessManager: ScreenBrightnessManaging
    private let chatNavigator: ChatNavigator
    
    init(
        brightnessManager: ScreenBrightnessManaging,
        chatNavigator: ChatNavigator
    ) {
        self.brightnessManager = brightnessManager
        self.chatNavigator = chatNavigator
    }
    
    func setFullBrightness(){
        brightnessManager.setBrightness(.maximum)
    }
    
    func restoreBrightness(){
        brightnessManager.restoreBrightness()
    }
    
    func handleSceneBrightness(for phase: ScenePhase){
        switch phase {
        case .background:
            restoreBrightness()
        case .inactive:
            restoreBrightness()
        case .active:
            setFullBrightness()
        @unknown default:
            break
        }
    }
    
    func resetQRCode(){
        
    }
    
    var qrContent: String {
        "https://www.apple.com"
    }
    
    func didScanUser() async{

        await chatNavigator.openChat()

    }
}
