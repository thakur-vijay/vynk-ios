//
//  ChatContextMenu.swift
//  VynkChatsKit
//
//  Created by Vijay Thakur on 12/07/26.
//


import SwiftUI

struct ChatContextMenu: View {
    let userName: String
    let onAction: (ChatContextAction) -> Void

    var body: some View {
        ForEach(ChatContextAction.allActions(userName: userName)) { action in
            Button(role: action.role){
                onAction(action)
            } label: {
                Label(action.label, systemImage: action.symbol)
            }
        }
    }
}