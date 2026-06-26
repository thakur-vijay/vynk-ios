//
//  ListsActionSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import Foundation

enum ListsActionSheet: Identifiable{
    case createNewList
    case editList(id: String)
    case reorderList
    
    var id: String {
        switch self {
        case .createNewList: "createNewList"
        case .editList: "editList"
        case .reorderList: "reorderList"
        }
    }
}
