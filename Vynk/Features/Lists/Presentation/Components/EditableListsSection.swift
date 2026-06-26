//
//  EditableListsSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import SwiftUI

struct EditableListsSection: View {
    let lists: [ChatListRowModel]
    let onMove: (_ source: IndexSet, _ destination: Int) -> Void
    let onDeleteRequest: (ChatListRowModel) -> Void
    var body: some View {
        Section {
            ForEach(lists) { list in
                Text(list.title)
                    .foregroundStyle(.primary)
                    .deleteDisabled(!list.canDelete)
                    .id("\(list.id)-\(list.canDelete)")
                    .task {
                        AppLogger.debug(list.id, list.canDelete, tag: list.title)
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

/*
 Thread 1: "Invalid update: invalid number of items in section 0. The number of items contained in an existing section after the update (7) must be equal to the number of items contained in that section before the update (6), plus or minus the number of items inserted or deleted from that section (0 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out). Collection view: <SwiftUI.UpdateCoalescingCollectionView: 0x111951c00; baseClass = UICollectionView; frame = (0 0; 428 879); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x11ca03320>; backgroundColor = <UIDynamicSystemColor: 0x11089cf40; name = systemGroupedBackgroundColor>; layer = <CALayer: 0x110a65e00>; contentOffset: {0, -74}; contentSize: {428, 466.83333333333337}; adjustedContentInset: {74, 0, 34, 0} topEdge=<style=automatic backgroundCapture=color<<UIDynamicSystemColor: 0x10472dd80; name = systemBackgroundColor>>>; layout: <UICollectionViewCompositionalLayout: 0x11cb80f00>; d"
 */
