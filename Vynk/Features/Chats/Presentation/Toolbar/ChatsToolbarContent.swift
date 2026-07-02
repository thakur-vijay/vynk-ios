//
//  ChatsToolbarContent.swift
//  Vynk
//
//  Created by Vijay Thakur on 30/05/26.
//

import SwiftUI

struct ChatsToolbarContent: ToolbarContent {
    var onAddTap:()->()
    var onCameraTap: ()->()
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    
                } label: {
                    Label("Select chats", systemImage: AppSymbols.checkmarkCircle.name)
                }
                
                Button {
                    
                } label: {
                    Label("Read all", systemImage: AppSymbols.checkmarkBubble.name)
                }
            } label: {
                Image(systemName: "ellipsis")
            }
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                
            } label: {
                AppSymbols.rupeeFill.image
            }
            
            Button(action: onCameraTap){
                AppSymbols.camera.image
            }
        }
        
        ProminentToolbarButton(action: onAddTap)
    }
}
