//
//  NewChatBottomSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct NewChatBottomSheet: View {
    @Environment(\.appDIContainer) private var appDIContainer
    var body: some View {
        NavigationStack {
            List {
                appDIContainer.contactsDIContainer.makeContactsView()
            }
            .background(AppColors.backgroundSecondary)
            .navigationTitle("New chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: AppIcons.close, role: .close) {
                        
                    }
                }
            }
        }
    }
}
