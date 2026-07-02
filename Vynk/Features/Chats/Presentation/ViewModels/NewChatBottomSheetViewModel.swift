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
        .init(id: .newGroup, title: "New group", symbol: AppSymbols.newGroup.name),
        .init(id: .newContact, title: "New contact", symbol: AppSymbols.newPerson.name),
        .init(id: .newCommunity, title: "New community", subtitle: "Bring together topic-based groups", symbol: AppSymbols.group.name),
        .init(id: .newBroadcast, title: "New broadcast", symbol: AppSymbols.broadcast.name),
    ]
    
    var search: String = ""
}
