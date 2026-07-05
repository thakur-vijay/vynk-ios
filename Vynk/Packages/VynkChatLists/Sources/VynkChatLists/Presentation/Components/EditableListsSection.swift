//
//  EditableListsSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import SwiftUI
import VynkFoundation
import VynkDesignSystem

struct EditableListsSection: View {
    let lists: [ChatListRowModel]
    let onMove: (_ source: IndexSet, _ destination: Int) -> Void
    let onDeleteRequest: (ChatListRowModel) -> Void
    var body: some View {
        Section {
            ForEach(lists) { list in
                HStack(spacing: AppSpacing.md) {
                    if list.canDelete {
                        Button("", systemImage: AppSymbols.delete.name) {
                            onDeleteRequest(list)
                        }
                        .foregroundStyle(AppColors.red)
                        .tint(AppColors.red)
                        .frame(width: 24)
                    }else {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 24)
                    }
                    
                    Text(list.title)
                        .foregroundStyle(.primary)
                        .id("\(list.id)-\(list.canDelete)")
                }
                .deleteDisabled(true)
                .swipeActions(edge: .trailing) {
                    if list.canDelete {
                        Button("Delete") {
                            onDeleteRequest(list)
                        }
                    }
                }
            }
            .onMove { indexSet, destination in
                onMove(indexSet, destination)
            }
            .onDelete { indexSet in
                guard let index = indexSet.first else { return }
                let list = lists[index]
                guard list.canDelete else { return }
                onDeleteRequest(list)
            }
        } header: {
            Text("Your lists")
        }

    }

}
