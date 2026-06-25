//
//  ProfileQRCodeRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//


@LifecycleLogged
@MainActor
@Observable
final class ProfileQRCodeRouter {
    var activeFullScreenCover: ProfileQRCodeFullScreenCover?
    var activeSheet: ProfileQRCodeSheet?
    
    func presentSheet(_ sheet: ProfileQRCodeSheet){
        activeSheet = sheet
    }

    func dismissSheet() {
        activeSheet = nil
    }
    
    func presentFullScreenCover(_ fullScreenCover: ProfileQRCodeFullScreenCover){
        activeFullScreenCover = fullScreenCover
    }

    func dismissFullScreenCover() {
        activeSheet = nil
    }

}
