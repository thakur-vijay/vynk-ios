//
//  ChatListAlertFactory.swift
//  Vynk
//
//  Created by Vijay Thakur on 23/06/26.
//

import SwiftUI
import VynkDesignSystem

public enum ChatListAlertFactory {

    public static func makeDeleteAlert(
        for list: ChatListRowModel,
        onDelete: @escaping () -> Void
    ) -> DialogConfiguration? {

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
