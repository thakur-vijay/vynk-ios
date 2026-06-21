//
//  ListsRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import Foundation

@MainActor
@Observable
final class ListsRouter {
    
    private(set) var activeSheet: ListsActionSheet?
    
    func presentSheet(_ sheet: ListsActionSheet){
        activeSheet = sheet
    }
    
    func dismissSheet(){
        activeSheet = nil
    }
}
