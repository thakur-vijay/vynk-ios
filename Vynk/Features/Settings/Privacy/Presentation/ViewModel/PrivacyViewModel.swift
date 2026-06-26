//
//  PrivacyViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class PrivacyViewModel {
    
    var sections: [SectionModel<PrivaceRowID>] = [
        .init(rows: [
            .init(id: .lastSeenAndOnline, title: "Last seen & online", trailingText: "Nobody", kind: .navigation),
            .init(id: .profilePicture, title: "Profile picture", trailingText: "Everyone", kind: .navigation),
            .init(id: .about, title: "About", trailingText: "Nobody", kind: .navigation),
            .init(id: .links, title: "Links", trailingText: "Nobody", kind: .navigation),
            .init(id: .groups, title: "Groups", trailingText: "193 Excluded", kind: .navigation),
            .init(id: .avatarStickers, title: "Avatar stickers", trailingText: "O Included", kind: .navigation),
            .init(id: .status, title: "Status", trailingText: "My contacts", kind: .navigation),
        ]),
        .init(
            footer: "List of chats where you are sharing your live location.",
            rows: [
                .init(id: .liveLocation, title: "Live location", trailingText: "None", kind: .navigation),
            ]
        ),
        .init(
            rows: [
                .init(id: .calls, title: "Calls", kind: .navigation),
            ]
        ),
        .init(
            rows: [
                .init(id: .contacts, title: "Contacts", kind: .navigation),
            ]
        ),
        .init(
            header: "Disappearing messages",
            footer: "Start new chats with disappearing messages set to your timer.",
            rows: [
                .init(id: .defaultMessageTimer, title: "Default message timer", trailingText: "Off", kind: .navigation),
            ]
        ),
        .init(
            footer: "If you turn off read receipts, you won't be able to see read receipts from other people. Read receipts are always sent for group chats.",
            rows: [
                .init(id: .readReceipts, title: "Read receipts", kind: .toggle),
            ]
        ),
        .init(
            footer: "Require Face ID to unlock Vynk.",
            rows: [
                .init(id: .appLock, title: "App lock", kind: .navigation),
            ]
        ),
        .init(
            rows: [
                .init(id: .chatLock, title: "Chat lock", kind: .navigation),
            ]
        ),
        .init(
            footer: "Use effects in the camera and video calls. Learn more",
            rows: [
                .init(id: .allowCameraEffects, title: "Allow camera effects", kind: .toggle),
            ]
        ),
        .init(
            rows: [
                .init(id: .advanced, title: "Advanced", kind: .navigation),
            ]
        ),
        .init(
            rows: [
                .init(id: .privacyCheckup, title: "Privacy checkup", kind: .navigation),
            ]
        ),
    ]
    
    var isReadReceiptsEnabled = false
    var isCameraEffectsEnabled = false
    
    
    func binding(for rowID: PrivaceRowID) -> Binding<Bool> {
        Binding(
            get: {
                switch rowID {
                case .readReceipts:
                    self.isReadReceiptsEnabled

                case .allowCameraEffects:
                    self.isCameraEffectsEnabled

                default:
                    false
                }
            },
            set: { newValue in
                switch rowID {
                case .readReceipts:
                    self.isReadReceiptsEnabled = newValue

                case .allowCameraEffects:
                    self.isCameraEffectsEnabled = newValue

                default:
                    break
                }
            }
        )
    }
}
