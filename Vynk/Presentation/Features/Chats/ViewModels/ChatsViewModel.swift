//
//  ChatsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

enum ChatsRoute: Hashable {
    case detail(ChatRowModel)
}

@MainActor
@Observable
final class ChatsViewModel {
    var searchText: String = ""
    var isSearchPresented: Bool = false
    
    var path: [ChatsRoute] = []
    var chats: [ChatRowModel] = ChatRowModel.sampleList
    
    
    
    func openChat(_ chat: ChatRowModel) {
        
        path.append(.detail(chat))
        
    }
}
