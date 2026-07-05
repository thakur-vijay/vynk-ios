//
//  CreateNewListViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import Foundation
import VynkFoundation
import SwiftUI

@available(iOS 17.0, *)
@MainActor
@Observable
final class ListEditorViewModel {
    
    private let mode: ListEditorMode
    private(set) var navigationTitle: String = ""
    var title: String = ""
    
    private let saveChatListUseCase: SaveChatListUseCase
    
    init(
        mode: ListEditorMode,
        saveChatListUseCase: SaveChatListUseCase
    ) {
        self.mode = mode
        self.saveChatListUseCase = saveChatListUseCase
    }
    
    func prepare()async{
        switch mode {
        case .create:
            navigationTitle = "New list"
        case .edit:
            navigationTitle = "Edit list"
        }
    }
    
    func saveList(onClose: @escaping ()->()) async{
        do {
            try await saveChatListUseCase.execute(title: title)
            onClose()
        }catch {
            Log.error(error.localizedDescription)
        }
    }
    
    var isEnabled: Bool {
        return title.isNotBlank
    }
    
    func clear(){
        title = ""
    }
}
