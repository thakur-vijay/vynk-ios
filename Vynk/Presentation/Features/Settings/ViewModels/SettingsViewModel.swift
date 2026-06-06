//
//  SettingsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import Foundation

@MainActor
@Observable
final class SettingsViewModel {

    var sections: [SectionModel<SettingsRowID>] = [
        .init(rows: [
            .init(id: .lists, title: "Lists", kind: .navigation),
            .init(id: .broadcastMessages, title: "Broadcast messages", kind: .navigation),
            .init(id: .starred, title: "Starred", kind: .navigation),
            .init(id: .linkedDevices, title: "Linked devices", kind: .navigation),
        ]),
        .init(rows: [
            .init(id: .account, title: "Account", kind: .navigation),
            .init(id: .privacy, title: "Privacy", kind: .navigation),
            .init(id: .chats, title: "Chats", kind: .navigation),
            .init(id: .notifications, title: "Notifications", kind: .navigation),
            .init(id: .payments, title: "Payments", kind: .navigation),
            .init(id: .storageAndData, title: "Storage and data", kind: .navigation),
        ]),
        .init(rows: [
            .init(id: .helpAndFeedback, title: "Help and feedback", kind: .navigation),
            .init(id: .inviteAFriend, title: "Invite a friend", kind: .navigation)
        ])
    ]
}
