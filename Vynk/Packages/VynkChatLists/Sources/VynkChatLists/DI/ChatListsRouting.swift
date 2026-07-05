//
//  File.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

@available(iOS 17.0, *)
public protocol ChatListsRouting {
    func makeObserveVisibleListsUseCase()-> ObserveVisibleListsUseCase
    
    func makeDeleteListsUseCase()-> DeleteChatListUseCase
    
}
