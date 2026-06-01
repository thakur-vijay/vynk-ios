//
//  NewChatBottomSheetViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

@MainActor
@Observable
final class NewChatBottomSheetViewModel {
    
    var quickActions: [QuickActionModel<NewChatQuickActionID>] = [
        .init(id: .newGroup, title: "New group", symbol: AppIcons.newGroup),
        .init(id: .newContact, title: "New contact", symbol: AppIcons.newPerson),
        .init(id: .newCommunity, title: "New community", subtitle: "Bring together topic-based groups", symbol: AppIcons.group),
        .init(id: .newBroadcast, title: "New broadcast", symbol: AppIcons.broadcast),
    ]
    
    var search: String = ""
}
