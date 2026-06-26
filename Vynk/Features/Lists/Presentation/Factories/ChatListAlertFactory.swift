//
//  ChatListAlertFactory.swift
//  Vynk
//
//  Created by Vijay Thakur on 23/06/26.
//

import SwiftUI

enum ChatListAlertFactory {

    static func makeDeleteAlert(
        for list: ChatListRowModel,
        onDelete: @escaping () -> Void
    ) -> DialogConfig? {

        return .init(
            title: "Delete \(list.title)",
            message: list.deleteAlertMessage,
            actions: [
                .init(
                    title: "Delete",
                    role: .destructive,
                    action: onDelete
                )
            ]
        )
    }
}
