//
//  NewChatBottomSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct NewChatBottomSheet<Content: View>: View {
    @State private var viewModel: NewChatBottomSheetViewModel
    var content: Content
    let onClose: ()->()
    init(viewModel: NewChatBottomSheetViewModel, @ViewBuilder content: @escaping ()->Content, onClose: @escaping () -> Void) {
        _viewModel = State(wrappedValue: viewModel)
        self.content = content()
        self.onClose = onClose
    }
    var body: some View {
        NavigationStack {
            List {
                QuickActionsSection(actions: viewModel.quickActions) { action in
                    
                }
                .listSectionMargins(.top, 5)
                content
            }
            .background(AppColors.backgroundSecondary)
            .navigationTitle("New chat")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.search, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search name or number"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: AppIcons.close, role: .close, action: onClose)
                }
            }
        }
    }
}
