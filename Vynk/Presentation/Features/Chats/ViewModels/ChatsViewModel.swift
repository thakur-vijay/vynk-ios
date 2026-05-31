//
//  ChatsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

@MainActor
@Observable
final class ChatsViewModel {
    var searchText: String = ""
    var isSearchPresented: Bool = false
    var chats: [MessageThreadRowModel] = MockDataFactory.chats
    
    var router: ChatsRouter
    
    init(router: ChatsRouter) {
        self.router = router
    }
    
    func openChat(_ model: MessageThreadRowModel){
        router.push(.detail(model))
    }
    
    func openUserDetail(){
        router.push(.userDetail)
    }
}
