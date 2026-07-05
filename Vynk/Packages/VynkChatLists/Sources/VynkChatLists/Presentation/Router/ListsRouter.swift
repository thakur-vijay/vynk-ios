//
//  ListsRouter.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import Foundation

@available(iOS 17.0, *)
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
