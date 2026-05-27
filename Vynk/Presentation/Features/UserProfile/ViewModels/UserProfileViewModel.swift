//
//  UserProfileViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import Foundation

@MainActor
@Observable
final class UserProfileViewModel {
    
    var sections: [[SettingsRowModel<UserProfileRowID>]] = [
        [
            .init(
                id: .media,
                title: "Media, links and docs",
                trailingText: "2",
                kind: .navigation
            ),
            .init(
                id: .storage,
                title: "Manage storage",
                trailingText: "3 MB",
                kind: .navigation
            ),
            .init(
                id: .starred,
                title: "Starred",
                trailingText: "None",
                kind: .navigation
            )
        ],
        [
            .init(
                id: .notifications,
                title: "Notifications",
                kind: .navigation
            ),
            .init(
                id: .chatTheme,
                title: "Chat theme",
                kind: .navigation
            ),
            .init(
                id: .saveToPhotos,
                title: "Save to Photos",
                trailingText: "Default",
                kind: .navigation
            )
        ],
        [
            .init(
                id: .disappearingMessages,
                title: "Disappearing messages",
                trailingText: "Off",
                kind: .navigation
            ),
            .init(
                id: .lockChat,
                title: "Lock chat",
                subtitle: "Lock and hide this chat on this device.",
                kind: .toggle(isOn: false)
            ),
            .init(
                id: .advancedChatPrivacy,
                title: "Advanced chat privacy",
                trailingText: "Off",
                kind: .navigation
            ),
            .init(
                id: .encryption,
                title: "Encryption",
                subtitle: "Messages and calls are end-to-end encrypted. Tap to verify",
                kind: .navigation
            )
        ],
        [
            .init(
                id: .contactDetails,
                title: "Contact details",
                kind: .navigation
            )
        ],
        [
            .init(id: .shareContact, title: "Share contact", kind: .action(style: .accent), showsChevron: false),
            .init(id: .addToFavourites, title: "Add to Favourites", kind: .action(style: .accent), showsChevron: false),
            .init(id: .addToList, title: "Add to list", kind: .action(style: .accent), showsChevron: false),
            .init(id: .exportChat, title: "Export chat", kind: .action(style: .accent), showsChevron: false),
            .init(id: .clearChat, title: "Clear chat", kind: .destructive, showsChevron: false),
        ],
        [
            .init(id: .block, title: "Block Vijay Thakur", kind: .destructive, showsChevron: false),
            .init(id: .report, title: "Report Vijay Thakur", kind: .destructive, showsChevron: false),
        ]
    ]
}
