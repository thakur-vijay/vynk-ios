//
//  ListsSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import SwiftUI

struct ListsSection: View {
    let isCustomListsEmpty: Bool
    let lists: [ChatListRowModel]
    let addNew: ()->()
    var body: some View {
        Section {
            if !isCustomListsEmpty{
                Button(action: addNew){
                    Text("New list")
                        .foregroundStyle(AppColors.accentEmphasized)
                }
            }
            ForEach(lists) { list in
                Button {
                    
                } label: {
                    NavigationLink {
                        
                    } label: {
                        Text(list.title)
                    }
                    .allowsHitTesting(false)
                }
                .tint(.primary)

            }
        } header: {
            Text("Your lists")
        } footer: {
            Text("You can edit your lists and reorder how they appear in the Chats tab.")
        }

    }
    
}
