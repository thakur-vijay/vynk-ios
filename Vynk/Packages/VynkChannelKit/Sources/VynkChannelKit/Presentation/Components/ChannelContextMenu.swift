//
//  ChatContextMenu.swift
//  VynkChannelKit
//
//  Created by Vijay Thakur on 16/07/26.
//


import SwiftUI

struct ChannelContextMenu: View {
    let userName: String
    let onAction: (ChannelContextAction) -> Void

    var body: some View {
        ForEach(ChannelContextAction.allActions(userName: userName)) { action in
            Button(role: action.role){
                onAction(action)
            } label: {
                Label(action.label, systemImage: action.symbol)
            }
        }
    }
}
