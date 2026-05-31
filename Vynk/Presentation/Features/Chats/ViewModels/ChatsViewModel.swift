//
//  ChatsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

enum ChatsRoute: Hashable {
    case detail(MessageThreadRowModel)
    case userDetail
}

@MainActor
@Observable
final class ChatsViewModel {
    var searchText: String = ""
    var isSearchPresented: Bool = false
    var isNewChatBottomSheetPresented: Bool = false
    
    var path: [ChatsRoute] = []
    var chats: [MessageThreadRowModel] = MockDataFactory.chats
    
    
    
    func openChat(_ chat: MessageThreadRowModel) {
        path.append(.detail(chat))
    }
    
    func openUserDetail(){
        path.append(.userDetail)
    }
}
