//
//  ChatsToolbarContent.swift
//  Vynk
//
//  Created by Vijay Thakur on 30/05/26.
//

import SwiftUI

struct ChatsToolbarContent: ToolbarContent {
    var onAddTap:()->()
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    
                } label: {
                    Label("Select chats", systemImage: AppIcons.checkmarkCircle)
                }
                
                Button {
                    
                } label: {
                    Label("Read all", systemImage: AppIcons.checkmarkBubble)
                }
            } label: {
                Image(systemName: "ellipsis")
            }
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                
            } label: {
                Image(systemName: AppIcons.rupeeFill)
            }
            
            Button {
                
            } label: {
                Image(systemName: AppIcons.camera)
            }
        }
        
        ProminentToolbarButton(action: onAddTap)
    }
}
